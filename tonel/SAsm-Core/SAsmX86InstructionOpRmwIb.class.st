Class {
	#name : #SAsmX86InstructionOpRmwIb,
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
SAsmX86InstructionOpRmwIb >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterOrRegisterAddressWord
		and: [ anInstruction second isImmediateS8 ] ]
]

{ #category : #accessing }
SAsmX86InstructionOpRmwIb >> parameters: extraParameters [
	registerOpcode := extraParameters first
]

{ #category : #writing }
SAsmX86InstructionOpRmwIb >> writeInstruction: instruction with: writer [
	| immediate registerAddress operandSize |
	registerAddress := instruction first.
	immediate := instruction second.
	self assert: immediate isImmediate.
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
	self write: writer modRM: registerAddress opcode: registerOpcode immediate: 1.
	writer nextPutI8: immediate
]
