Class {
	#name : #SAsmX86InstructionLowerer,
	#superclass : #SAsmCompilationTarget,
	#instVars : [
		'target',
		'function',
		'streamBuilder'
	],
	#pools : [
		'SAsmX86Constants',
		'SAsmX86Instructions'
	],
	#category : #'SAsm-Core-X86'
}

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

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> moveMemory: rightPhysical toScratchIndex: scratchIndex [
	
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
		self halt.
	] ifFalse: [ 
		^ streamBuilder x86: MOV dst: physical src: valuePhysical
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
	^ function callingConvention scratchRegisters first
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
