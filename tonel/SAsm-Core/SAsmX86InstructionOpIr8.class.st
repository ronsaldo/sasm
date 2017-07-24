Class {
	#name : #SAsmX86InstructionOpIr8,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpIr8 >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 1
		and: [ anInstruction first isImmediate
		and: [ anInstruction first isImmediateS8RelativeTo: anInstruction position: anInstruction position offset: 1 + opcode size ] ]
]

{ #category : #accessing }
SAsmX86InstructionOpIr8 >> maxSize [
	^ opcode size + 1
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpIr8 >> writeInstruction: instruction with: writer [
	writer nextPutAll: opcode.
	writer nextPutIPRelativeI8: instruction arguments first
]
