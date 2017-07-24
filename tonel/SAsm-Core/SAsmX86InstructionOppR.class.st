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

{ #category : #accessing }
SAsmX86InstructionOppR >> maxSize [
	self assert: opcode size = 1.
	^ 2
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOppR >> writeInstruction: instruction with: writer [
	| register |
	register := instruction arguments first.
	self write: writer rexRM: register.
	self write: writer opcodePlusRegister: register
]
