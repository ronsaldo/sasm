Class {
	#name : #SAsmInstructionLowerer,
	#superclass : #SAsmObject,
	#instVars : [
		'target',
		'function',
		'streamBuilder',
		'allocatableRegisterClasses',
		'scratchRegisterClases',
		'usedRegisters',
		'freeRegisters',
		'freeSpillLocations',
		'stackFrameLayout',
		'maxCallStackSize',
		'registersToPreserve'
	],
	#classVars : [
		'ContextMetadataElementCount',
		'StackPageSize',
		'StackSwitchPointerRequired'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'class initialization' }
SAsmInstructionLowerer class >> initialize [
	super initialize.
	
	ContextMetadataElementCount := 4.
	StackSwitchPointerRequired := 4. "Frame Pointer, link pointer(optional), selector, argument description".
	StackPageSize := 4096.
]

{ #category : #'register allocation' }
SAsmInstructionLowerer >> allocateRegisters [
	| callingConvention allocatableRegisters |
	maxCallStackSize := 0.
	function computeVirtualRegisterLiveRanges.
	stackFrameLayout := function stackFrameLayout copy.
	callingConvention := function callingConvention.
	allocatableRegisters := callingConvention allocatableRegisters.
	target hasPositionIndependentCode ifTrue: [ 
		allocatableRegisters := allocatableRegisters copyWithout: target gotBaseRegister.
	].
	
	allocatableRegisterClasses := self buildRegisterClasses: allocatableRegisters.
	scratchRegisterClases := self buildRegisterClasses: callingConvention scratchRegisters.
	usedRegisters := Set new.
	self
		assignRegistersToArguments;
		performLinearScanRegisterAllocation.

	registersToPreserve := callingConvention callerRegisters select: [ :reg | usedRegisters includes: reg ].
	self buildStackFrameLayout	
]

{ #category : #'register allocation' }
SAsmInstructionLowerer >> allocateSpillLocationForVirtualRegister: virtualRegister [
	| spillClass freeLocations spillLocation |
	spillClass := virtualRegister spillingClass.
	freeLocations := freeSpillLocations at: spillClass ifAbsentPut: [ OrderedCollection new ].
	freeLocations ifNotEmpty: [
		spillLocation := freeLocations last.
		freeLocations removeLast.
	] ifEmpty: [
		spillLocation := self createLocal: spillClass
	].

	^ spillLocation
]

{ #category : #'register allocation' }
SAsmInstructionLowerer >> assignRegistersToArguments [
	| callingConvention  integerArgumentRegisters floatArgumentRegisters intRegisterIndex floatRegisterIndex |
	callingConvention := function callingConvention.
	integerArgumentRegisters := callingConvention integerArgumentRegisters.
	floatArgumentRegisters := callingConvention integerArgumentRegisters.
	intRegisterIndex := 1.
	floatRegisterIndex := 1.
	stackFrameLayout arguments do: [ :arg |
		(arg argumentRegisterClass == #integer and: [ intRegisterIndex <= integerArgumentRegisters size ]) ifTrue: [ 
			arg argumentPassingRegister: (integerArgumentRegisters at: intRegisterIndex).
			intRegisterIndex := intRegisterIndex + 1
		].
		(arg argumentRegisterClass == #float and: [ floatRegisterIndex <= floatArgumentRegisters size]) ifTrue: [ 
			arg argumentPassingRegister: (floatArgumentRegisters at: floatRegisterIndex).
			floatRegisterIndex := floatRegisterIndex + 1
		].
	].

]

{ #category : #'register allocation' }
SAsmInstructionLowerer >> buildRegisterClasses: registers [
	| registerClasses |
	registerClasses := Dictionary new.
	registers do: [ :reg | (registerClasses at: reg class ifAbsentPut: [ OrderedCollection new ]) add: reg ].
	^ registerClasses
	
]

{ #category : #'register allocation' }
SAsmInstructionLowerer >> buildStackFrameLayout [
	| callingConvention pointerSize |
	callingConvention := function callingConvention.
	pointerSize := target pointerSize.
	stackFrameLayout
		stackAlignment: callingConvention stackAlignment;
		argumentsBaseOffset: 2 * pointerSize;
		localsBaseOffset: 2 * pointerSize;
		addLocalReservedSpace: 2 * pointerSize "Return pointer + frame pointer".
		
	stackFrameLayout addLocalReservedSpace: registersToPreserve size * pointerSize.
	(callingConvention hasContextMetadata or: [function contextMetaData isNotNil]) ifTrue: [
		stackFrameLayout addLocalReservedSpace: ContextMetadataElementCount * pointerSize.
	].

	stackFrameLayout optimizeAndBuildLayout.
	"stackFrameLayout buildLayout."
]

{ #category : #'stack frame' }
SAsmInstructionLowerer >> computeArgumentDescriptor [
	| oopArgumentCount nativeArgumentsSize totalArgumentSize alignedArgumentSize alignmentPaddingSize callingConvention nativeArgumentAlignment |
	oopArgumentCount := 0.
	nativeArgumentsSize := 0.
	callingConvention := function callingConvention.
	nativeArgumentAlignment := target pointerSize.
	stackFrameLayout arguments doWithIndex: [ :arg :index |
		arg dynamicRoot ifTrue: [
			oopArgumentCount := oopArgumentCount + 1
		] ifFalse: [
			nativeArgumentAlignment := nativeArgumentAlignment max: arg alignment.
			nativeArgumentsSize := nativeArgumentsSize + (arg size alignedTo: (arg alignment max: callingConvention stackArgumentAlignment))
		]
	].

	"Align the arguments"
	totalArgumentSize := nativeArgumentsSize + (oopArgumentCount * target pointerSize).
	alignedArgumentSize := totalArgumentSize alignedTo: callingConvention stackAlignment.
	alignmentPaddingSize := alignedArgumentSize - totalArgumentSize.
	nativeArgumentsSize := nativeArgumentsSize + alignmentPaddingSize.

	self flag: 'Synchronize properly with SLVMFunctionType >> #argumentsDescriptorWithTarget:'.
	^ oopArgumentCount | (nativeArgumentsSize << 8) | (((nativeArgumentAlignment highBit - target pointerSize highBit) max: 0) << 24) | callingConvention argumentDescriptorFlags
]

{ #category : #'register allocation' }
SAsmInstructionLowerer >> createLocal: spillClass [
	^ stackFrameLayout createLocal: spillClass
]

{ #category : #'register allocation' }
SAsmInstructionLowerer >> freeRegister: register [
	register ifNil: [ ^ self ].
	(freeRegisters at: register class) add: register
]

{ #category : #'register allocation' }
SAsmInstructionLowerer >> freeSpillLocation: spillLocation [
	spillLocation ifNil: [ ^ self ].
	(freeSpillLocations at: spillLocation spillClass) add: spillLocation.
]

{ #category : #accessing }
SAsmInstructionLowerer >> function [
	^ function
]

{ #category : #accessing }
SAsmInstructionLowerer >> function: anObject [
	function := anObject
]

{ #category : #'abstract instruction generation' }
SAsmInstructionLowerer >> lowerConditional: condition branch: branch [
	condition accept: self.
	branch accept: self
]

{ #category : #'abstract instruction generation' }
SAsmInstructionLowerer >> lowerInstruction: instruction writeToStream: aStreamBuilder [
	| nextInstruction |
	streamBuilder := aStreamBuilder.
	nextInstruction := instruction nonDebugNext.
	(instruction isThreeAddressInstruction and: [ nextInstruction isNotNil ]) ifTrue: [
		"Condition + Branch -> Conditional Branch"
		(instruction isCondition and: [
		 nextInstruction isThreeAddressInstruction and: [
		 nextInstruction isConditionalJump and: [
		 nextInstruction condition == instruction result and:[
		 instruction result end == nextInstruction index ]]]] ) ifTrue: [
			self lowerConditional: instruction branch: nextInstruction.
			^ nextInstruction next
		]
	].

	instruction accept: self.
	^ instruction next
]

{ #category : #'register allocation' }
SAsmInstructionLowerer >> mapVirtualRegister: virtualRegister toSpillLocation: spillLocation [
	self flag: 'TODO: add a mapping entry for debugging.'
]

{ #category : #testing }
SAsmInstructionLowerer >> needsToSpillThreeAddressInstruction: tacInstruction [
	^ false
]

{ #category : #'runtime functions' }
SAsmInstructionLowerer >> nilGlobalSymbol [
	^ self runtimeProvidedFunction: #'slvm_nil'
	
]

{ #category : #'register allocation' }
SAsmInstructionLowerer >> performLinearScanRegisterAllocation [
	| activeMemoryRanges activeRangeClasses sortedLiveRanges registerClass currentActiveRanges availableRegisters spilledRange spillingPoints finalActiveRanges |
	freeSpillLocations := Dictionary new.
	freeRegisters := Dictionary new.
	allocatableRegisterClasses keysAndValuesDo: [ :key :value |
		freeRegisters at: key put: value copy
	].

	spillingPoints := OrderedCollection new.
	function basicBlocks do: [ :bb |
		bb do: [ :instruction |
			(instruction needsToSpillWith: self) ifTrue: [ 
				spillingPoints add: instruction
			]
		]
	].
	spillingPoints sort: [ :a :b |  a index < b index ].

	activeMemoryRanges := SortedCollection sortBlock: [ :a :b | a end < b end ].
	activeRangeClasses := Dictionary new.
	sortedLiveRanges := function virtualRegisters select: #hasValidLiveRange.
	sortedLiveRanges sort.
	sortedLiveRanges do: [ :range | range spillLocation: nil ].
	
	sortedLiveRanges do: [ :virtualRegister |
		"Spill location allocation"
		virtualRegister variable ifNotNil: [
			virtualRegister spillLocation: (stackFrameLayout importVariable: virtualRegister variable)
		] ifNil: [ 
			self removeExpiredRangesUntil: virtualRegister start from: activeMemoryRanges do: [:expiredRange |
				self freeSpillLocation: expiredRange spillLocation.
			].
			virtualRegister spillLocation: (self allocateSpillLocationForVirtualRegister: virtualRegister).
			self mapVirtualRegister: virtualRegister toSpillLocation: virtualRegister spillLocation.
			activeMemoryRanges add: virtualRegister.
		].
	
		"Allocate the register"
		registerClass := virtualRegister registerClass.
		registerClass ifNotNil: [ 
			activeRangeClasses valuesDo: [ :activeRanges |
				self removeExpiredRangesUntil: virtualRegister firstUsage from: activeRanges do: [:expiredRange |
					self freeRegister: expiredRange register.
				].
			].
		
			currentActiveRanges := activeRangeClasses at: registerClass ifAbsentPut: [
				SortedCollection sortBlock: [ :a :b | a end < b end ]
			].
			
			availableRegisters := freeRegisters at: registerClass.
			availableRegisters ifEmpty: [
				"Spill here."
				spilledRange := currentActiveRanges last.
				spilledRange end > virtualRegister end ifTrue: [ 
					"range spillRange: spilledRange."
					virtualRegister register: spilledRange register.
					spilledRange register: nil.
					currentActiveRanges removeLast.
					currentActiveRanges add: virtualRegister.
				] ifFalse: [
					"Range is spilled. Nothing required."
				]
			] ifNotEmpty: [
				virtualRegister register: availableRegisters last.
				availableRegisters removeLast.
				usedRegisters add: virtualRegister register.
				currentActiveRanges add: virtualRegister.
			]
		].
	
		[spillingPoints isNotEmpty and: [spillingPoints first index <= virtualRegister firstUsage]] whileTrue: [
			spillingPoints first activeRegisters: currentActiveRanges asArray.
			currentActiveRanges do: [ :spilled | spilled spillLocation markAsSpilledExplicitly ].
			spillingPoints removeFirst
		]
	].

	currentActiveRanges ifNil: [ ^ self ].
	finalActiveRanges := currentActiveRanges asArray.
	spillingPoints do: [ :point |
		point activeRegisters: finalActiveRanges.
	]
]

{ #category : #'register allocation' }
SAsmInstructionLowerer >> removeExpiredRangesUntil: date from: rangeList do: aBlock [
	[rangeList isNotEmpty and: [ rangeList first end < date]] whileTrue: [
		aBlock value: rangeList first.
		rangeList removeFirst
	]
]

{ #category : #'runtime functions' }
SAsmInstructionLowerer >> runtimeProvidedFunction: aSymbol [
	self halt.
]

{ #category : #'runtime functions' }
SAsmInstructionLowerer >> stackLimitTrapSymbol [
	^ self runtimeProvidedFunction: #'_slvm_dynrun_stack_limit_trap'
	
]

{ #category : #accessing }
SAsmInstructionLowerer >> streamBuilder [
	^ streamBuilder
]

{ #category : #accessing }
SAsmInstructionLowerer >> streamBuilder: anObject [
	streamBuilder := anObject
]

{ #category : #accessing }
SAsmInstructionLowerer >> target [
	^ target
]

{ #category : #accessing }
SAsmInstructionLowerer >> target: anObject [
	target := anObject
]

{ #category : #'abstract instruction generation' }
SAsmInstructionLowerer >> virtualRegisterLocationToPhysicalLocation: virtualRegister [
	self subclassResponsibility
]

{ #category : #'abstract instruction generation' }
SAsmInstructionLowerer >> virtualToPhysical: register [
	register isVariable ifTrue: [ ^ self virtualRegisterLocationToPhysicalLocation: register ].
	register isVirtualRegister ifFalse: [ ^ register copyWithStreamBuilder: streamBuilder ].
	register register ifNotNil: [ ^ register register ].
	^ self virtualRegisterLocationToPhysicalLocation: register
]

{ #category : #'as yet unclassified' }
SAsmInstructionLowerer >> visitTacInstruction: instruction [
	instruction operation acceptInstruction: instruction with: self
]
