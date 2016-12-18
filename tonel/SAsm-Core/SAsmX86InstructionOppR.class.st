Class {
	#name : #SAsmX86InstructionOppR,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86InstructionOppR >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 1
		and: [ anInstruction first isRegisterWord]
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOppR >> writeInstruction: instruction with: writer [
	| register |
	register := instruction arguments first.
	self write: writer opcodePlusRegister: register
]
