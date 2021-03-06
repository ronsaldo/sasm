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
		'StackSwitchPointerRequired',
		'ThisContextPointerIndex'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'class initialization' }
SAsmInstructionLowerer class >> initialize [
	super initialize.
	
	ContextMetadataElementCount := 4.
	StackSwitchPointerRequired := 4. "Frame Pointer, link pointer(optional), selector, argument description".
	ThisContextPointerIndex := -2.
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

	"Ensure the GOT base register is preserved when required."
	registersToPreserve := callingConvention callerRegisters select: [ :reg | usedRegisters includes: reg ].
	(target needsSlotForGOTPointer and: [(registersToPreserve includes: target gotBaseRegister) not]) ifTrue: [
		(target hasPositionIndependentCode or: [callingConvention hasContextMetadata or: [function contextMetaData isNotNil]]) ifTrue: [
			registersToPreserve := {target gotBaseRegister} , registersToPreserve
		]
	].

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
		self assert: spillLocation dynamicRoot = virtualRegister dynamicRoot
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
	floatArgumentRegisters := callingConvention floatArgumentRegisters.
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
	alignedArgumentSize := totalArgumentSize alignedTo: nativeArgumentAlignment.
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
	spillLocation explicitLocalVariable ifTrue: [ ^ self ].
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

{ #category : #'as yet unclassified' }
SAsmInstructionLowerer >> mapOriginalVariableToGeneratedVariables [
	| imported |
	function stackFrameLayout arguments do: [ :arg |
		imported := stackFrameLayout importVariable: arg.
		streamBuilder localVariableToGeneratedMap at: arg put: imported
	].
	function stackFrameLayout localVariables do: [ :local |
		imported := stackFrameLayout importVariable: local.
		streamBuilder localVariableToGeneratedMap at: local put: imported
	].
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
	| activeMemoryRanges activeRangeClasses sortedLiveRanges registerClass currentActiveRanges availableRegisters spilledRange |
	freeSpillLocations := Dictionary new.
	freeRegisters := Dictionary new.
	allocatableRegisterClasses keysAndValuesDo: [ :key :value |
		freeRegisters at: key put: value copy
	].

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
			currentActiveRanges := activeRangeClasses at: registerClass ifAbsentPut: [
				SortedCollection sortBlock: [ :a :b | a end < b end ]
			].
			
			"Allocate the register"
			activeRangeClasses valuesDo: [ :activeRanges |
				self removeExpiredRangesUntil: virtualRegister firstUsage from: activeRanges do: [:expiredRange |			
					self freeRegister: expiredRange register.
				].
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
	].

	self storeAllocatedRegistersInSpillingPoints: sortedLiveRanges.
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
	aSymbol isSymbol ifTrue: [ ^ streamBuilder findOrCreateExternalSymbol: aSymbol type: #function].
	self halt.
]

{ #category : #'register allocation' }
SAsmInstructionLowerer >> selectSpillinPoint: point activeRangesFrom: liveRanges [
	| activeRanges |
	self flag: 'Use a lower bound binary search'.
	activeRanges := Array streamContents: [ :out |
		liveRanges do: [ :range |
			(range firstUsage < point index and: [point index <= range lastUsage]) ifTrue: [ 
				out nextPut: range
			]
		]
	].

	point activeRegisters: activeRanges.
	activeRanges do: [ :spilled | spilled spillLocation markAsSpilledExplicitly ].
]

{ #category : #'runtime functions' }
SAsmInstructionLowerer >> stackLimitTrapSymbol [
	^ self runtimeProvidedFunction: #'_slvm_dynrun_stack_limit_trap'
	
]

{ #category : #'register allocation' }
SAsmInstructionLowerer >> storeAllocatedRegistersInSpillingPoints: sortedLiveRanges [
	| spillingPoints allocatedLiveRanges |
	sortedLiveRanges ifEmpty: [ ^ self ].
	
	spillingPoints := OrderedCollection new.
	function basicBlocks do: [ :bb |
		bb do: [ :instruction |
			(instruction needsToSpillWith: self) ifTrue: [ 
				spillingPoints add: instruction
			]
		]
	].
	spillingPoints ifEmpty: [ ^ self ].
	spillingPoints sort: [ :a :b |  a index < b index ].
	
	allocatedLiveRanges := sortedLiveRanges select: [ :range | range register isNotNil ].
	
	spillingPoints do: [ :point |
		self selectSpillinPoint: point activeRangesFrom: allocatedLiveRanges
	].

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
	register isConstantPointer ifTrue: [ ^ register asX86PointerWithBuilder: streamBuilder ].
	register isVirtualRegister ifFalse: [ ^ register copyWithStreamBuilder: streamBuilder ].
	register register ifNotNil: [ ^ register register ].
	^ self virtualRegisterLocationToPhysicalLocation: register
]

{ #category : #'as yet unclassified' }
SAsmInstructionLowerer >> visitTacInstruction: instruction [
	instruction operation acceptInstruction: instruction with: self
]
