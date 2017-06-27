Class {
	#name : #SAsmX86InstructionOpRmbRb,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionOpRmbRb >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterOrRegisterAddressI8
		and: [ anInstruction second isRegisterI8  ] ]
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpRmbRb >> writeInstruction: instruction with: writer [
	| register registerAddress |
	registerAddress := instruction first.
	register := instruction second.
	self assert: register isRegister.
	self assert: registerAddress isRegisterOrRegisterAddress.
	self assert: register size = 1.
	
	self write: writer rexRM: registerAddress reg: register.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: register
]
