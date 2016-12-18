Class {
	#name : #SAsmX86InstructionOpRbRmb,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpRbRmb >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterI8
		and: [ anInstruction second isRegisterOrRegisterAddressI8 ] ]
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpRbRmb >> writeInstruction: instruction with: writer [
	| register registerAddress |
	register := instruction first.
	registerAddress := instruction second.
	self assert: register isRegister.
	self assert: registerAddress isRegisterOrRegisterAddress.
	self assert: register size = 1.
	
	self write: writer rexRM: registerAddress reg: register.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: register
]
