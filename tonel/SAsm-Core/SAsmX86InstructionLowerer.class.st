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

{ #category : #visiting }
SAsmX86InstructionLowerer >> enterFrame [
	function callingConvention isNaked ifTrue: [ ^ self ].
	self enterFramefullMethod
]

{ #category : #visiting }
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

{ #category : #visiting }
SAsmX86InstructionLowerer >> leaveFrame [
	function callingConvention isNaked ifTrue: [ ^ self ].
	self leaveFramefullMethod.
]

{ #category : #visiting }
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

{ #category : #visiting }
SAsmX86InstructionLowerer >> moveValue: value toRegister: register [
	value isImmediate ifTrue: [ ^ streamBuilder x86: MOV dst: register src: value ].
	self halt.
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> returnValue: value [
	value ifNil: [ ^ self ].
	self moveValue: value toRegister: function callingConvention resultIntRegister secondRegister: function callingConvention resultInt2Register
]

{ #category : #visiting }
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

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacCall: callInstruction [
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacMove: moveInstruction [
	| result value |
	result := moveInstruction result.
	value := moveInstruction value.
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacReturn: returnInstruction [
	self returnValue: returnInstruction left valueHigh: returnInstruction right.
	self leaveFrame.
	streamBuilder x86: RET
]
