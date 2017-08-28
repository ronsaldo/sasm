Class {
	#name : #SAsmX86InstructionOpRwRmb,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionOpRwRmb >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterWord
		and: [ anInstruction second isRegisterOrRegisterAddressI8 ] ]
]

{ #category : #writing }
SAsmX86InstructionOpRwRmb >> writeInstruction: instruction with: writer [
	| register registerAddress operandSize |
	register := instruction first.
	registerAddress := instruction second.
	self assert: register isRegister.
	self assert: registerAddress isRegisterOrRegisterAddress.
	operandSize := register size.
	self write: writer rexSize: operandSize rm: registerAddress reg: register.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: register
]
