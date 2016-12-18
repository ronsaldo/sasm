Class {
	#name : #SAsmX86InstructionOpRmwRw,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpRmwRw >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterOrRegisterAddress
		and: [ anInstruction second isRegisterWord ] ]
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpRmwRw >> writeInstruction: instruction with: writer [
	| register registerAddress operandSize |
	registerAddress := instruction first.
	register := instruction second.
	self assert: register isRegister.
	self assert: registerAddress isRegisterOrRegisterAddress.
	operandSize := register size.
	self assert: operandSize > 1.
	operandSize = 2 ifTrue: [
		self write: writer sizeOverrideIf: writer isShortMode not.
	].
	operandSize = 4 ifTrue: [
		self write: writer sizeOverrideIf: writer isShortMode.
	].
	self write: writer rexSize: operandSize rm: registerAddress reg: register.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: register
]
