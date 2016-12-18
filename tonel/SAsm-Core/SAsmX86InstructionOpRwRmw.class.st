Class {
	#name : #SAsmX86InstructionOpRwRmw,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpRwRmw >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterWord
		and: [ anInstruction second isRegisterOrRegisterAddress ] ]
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpRwRmw >> writeInstruction: instruction with: writer [
	| register registerAddress operandSize |
	register := instruction first.
	registerAddress := instruction second.
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
