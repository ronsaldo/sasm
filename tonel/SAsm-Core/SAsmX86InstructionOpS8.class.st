Class {
	#name : #SAsmX86InstructionOpS8,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpS8 >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 1
		and: [ anInstruction first isImmediateS8 ]
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpS8 >> writeInstruction: instruction with: writer [
	writer nextPutAll: opcode; nextPutI8: instruction arguments first
]
