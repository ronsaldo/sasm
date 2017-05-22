Class {
	#name : #SAsmX86InstructionOpRmwOp,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#instVars : [
		'registerOpcode'
	],
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionOpRmwOp >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 1
		and: [ anInstruction first isRegisterOrRegisterAddressWord]
]

{ #category : #testing }
SAsmX86InstructionOpRmwOp >> parameters: extraParameters [
	registerOpcode := extraParameters first
]

{ #category : #testing }
SAsmX86InstructionOpRmwOp >> writeInstruction: instruction with: writer [
	| registerAddress operandSize |
	registerAddress := instruction first.
	self assert: registerAddress isRegisterOrRegisterAddress.
	operandSize := registerAddress size.
	self assert: operandSize > 1.
	operandSize = 2 ifTrue: [
		self write: writer sizeOverrideIf: writer isShortMode not.
	].
	operandSize = 4 ifTrue: [
		self write: writer sizeOverrideIf: writer isShortMode.
	].
	self write: writer rexSize: operandSize rm: registerAddress reg: registerOpcode.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: registerOpcode immediate: 0.
]
