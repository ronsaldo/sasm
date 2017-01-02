Class {
	#name : #SAsmX86InstructionLowerer,
	#superclass : #SAsmCompilationTarget,
	#instVars : [
		'target',
		'function',
		'streamBuilder',
		'allocatableRegisterClasses',
		'scratchRegisterClases',
		'usedRegisters',
		'freeRegisters',
		'freeSpillLocations'
	],
	#pools : [
		'SAsmX86Constants',
		'SAsmX86Instructions'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'register allocation' }
SAsmX86InstructionLowerer >> allocateRegisters [
	| callingConvention |
	function computeVirtualRegisterLiveRanges.
	callingConvention := function callingConvention.
	allocatableRegisterClasses := self buildRegisterClasses: callingConvention allocatableRegisters.
	scratchRegisterClases := self buildRegisterClasses: callingConvention scratchRegisters.
	usedRegisters := Set new.
	self performLinearScanRegisterAllocation.
	self buildStackLayout.
]

{ #category : #'register allocation' }
SAsmX86InstructionLowerer >> allocateSpillLocationForVirtualRegister: virtualRegister [
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
SAsmX86InstructionLowerer >> buildRegisterClasses: registers [
	| registerClasses |
	registerClasses := Dictionary new.
	registers do: [ :reg | (registerClasses at: reg class ifAbsentPut: [ OrderedCollection new ]) add: reg ].
	^ registerClasses
	
]

{ #category : #'register allocation' }
SAsmX86InstructionLowerer >> buildStackLayout [
]

{ #category : #'register allocation' }
SAsmX86InstructionLowerer >> createLocal: spillClass [
	^ SAsmVariable new
		size: spillClass key;
		alignment: spillClass value;
		yourself
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> emitArithmeticInto: result left: left right: right integer: integerInstruction float: floatInstruction double: doubleInstruction [
	| resultPhysical rightPhysical rightRegister |
	self assert: result isRegisterOrRegisterAddress.

	left ~= result ifTrue: [
		self moveValue: left toRegister: result.
	].

	resultPhysical := self virtualToPhysical: result.
	rightPhysical := self virtualToPhysical: right.
	rightRegister := rightPhysical.
	(resultPhysical isRegisterAddress and: [ rightPhysical isRegisterAddress ]) ifTrue: [ 
		rightRegister := self moveMemory: rightPhysical toScratchIndex: 0
	].

	result isIntegerRegister ifTrue: [
		streamBuilder x86: integerInstruction with: resultPhysical with: rightRegister.
	].
	result isDoubleFloatRegister ifTrue: [
		streamBuilder x86: floatInstruction with: resultPhysical with: rightRegister.
	].
	result isFloatRegister ifTrue: [ 
		streamBuilder x86: doubleInstruction with: resultPhysical with: rightRegister.
	]

]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> enterFrame [
	function callingConvention isNaked ifTrue: [ ^ self ].
	self enterFramefullMethod
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> enterFramefullMethod [
	streamBuilder
		x86: PUSH with: target framePointerRegister;
		x86: MOV dst: target framePointerRegister src: target stackPointerRegister
]

{ #category : #'register allocation' }
SAsmX86InstructionLowerer >> freeRegister: register [
	register ifNil: [ ^ self ].
	(freeRegisters at: register class) add: register
]

{ #category : #'register allocation' }
SAsmX86InstructionLowerer >> freeSpillLocation: spillLocation [
	spillLocation ifNil: [ ^ self ].
	(freeSpillLocations at: spillLocation spillClass) add: spillLocation.
]

{ #category : #accessing }
SAsmX86InstructionLowerer >> function [
	^ function
]

{ #category : #accessing }
SAsmX86InstructionLowerer >> function: anObject [
	function := anObject
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> leaveFrame [
	function callingConvention isNaked ifTrue: [ ^ self ].
	self leaveFramefullMethod.
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> leaveFramefullMethod [
	streamBuilder
		x86: MOV dst: target stackPointerRegister src: target framePointerRegister;
		x86: POP with: target framePointerRegister.
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> lowerInstruction: instruction writeToStream: aStreamBuilder [
	streamBuilder := aStreamBuilder.
	instruction operation acceptInstruction: instruction with: self
]

{ #category : #'register allocation' }
SAsmX86InstructionLowerer >> mapVirtualRegister: virtualRegister toSpillLocation: spillLocation [
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> moveMemory: rightPhysical toScratchIndex: scratchIndex [
	self halt
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> moveValue: value toRegister: register [
	| physical valuePhysical |
	physical := self virtualToPhysical: register.
	self assert: physical isRegisterOrRegisterAddress.
	value isImmediate ifTrue: [
		^ streamBuilder x86: MOV dst: physical src: value
	].

	valuePhysical := self virtualToPhysical: value.
	valuePhysical == physical ifTrue: [ ^ self ].
	(valuePhysical isRegisterAddress and: [ register isRegisterAddress ]) ifTrue: [
		"TODO: Move temporarily to a scratch register"
		self halt.
	] ifFalse: [ 
		^ streamBuilder x86: MOV dst: physical src: valuePhysical
	]
	
]

{ #category : #'register allocation' }
SAsmX86InstructionLowerer >> performLinearScanRegisterAllocation [
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
	
	sortedLiveRanges do: [ :virtualRegister |
		"Spill location allocation"
		virtualRegister variable ifNotNil: [
			virtualRegister spillLocation: virtualRegister variable copy
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
		]
	].
	
]

{ #category : #'register allocation' }
SAsmX86InstructionLowerer >> removeExpiredRangesUntil: date from: rangeList do: aBlock [
	[rangeList isNotEmpty and: [ rangeList first end < date]] whileTrue: [
		aBlock value: rangeList first.
		rangeList removeFirst
	]
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> returnValue: value [
	value ifNil: [ ^ self ].
	self moveValue: value toRegister: function callingConvention resultIntRegister secondRegister: function callingConvention resultInt2Register
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> returnValue: value valueHigh: valueHigh [
	value ifNil: [ ^ self ].
	self
		moveValue: value toRegister: function callingConvention resultIntRegister.
	valueHigh ifNotNil: [ 
		self moveValue: value toRegister: function callingConvention resultInt2Register
	]
	
]

{ #category : #accessing }
SAsmX86InstructionLowerer >> streamBuilder [
	^ streamBuilder
]

{ #category : #accessing }
SAsmX86InstructionLowerer >> streamBuilder: anObject [
	streamBuilder := anObject
]

{ #category : #accessing }
SAsmX86InstructionLowerer >> target [
	^ target
]

{ #category : #accessing }
SAsmX86InstructionLowerer >> target: anObject [
	target := anObject
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> virtualToPhysical: register [
	register isVirtualRegister ifFalse: [ ^ register ].
	register register ifNotNil: [ ^ register register ].
	^ register spillLocation
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacAdd: instruction [
	^ self emitArithmeticInto: instruction result left: instruction left right: instruction right 
			integer: ADD float: ADD double: ADD
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacCall: callInstruction [
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacMove: moveInstruction [
	| result value |
	result := moveInstruction result.
	value := moveInstruction value.
	^ self moveValue: value toRegister: result
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacReturn: returnInstruction [
	self returnValue: returnInstruction left valueHigh: returnInstruction right.
	self leaveFrame.
	streamBuilder x86: RET
]
