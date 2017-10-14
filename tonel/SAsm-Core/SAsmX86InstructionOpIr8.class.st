Class {
	#name : #SAsmX86InstructionOpIr8,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpIr8 >> branchDestinationOfInstruction: anInstruction [
	^ anInstruction first
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpIr8 >> branchSpanOfInstruction: instruction [
	| destination |
	destination := instruction arguments first.
	^ destination immediateValueRelativeTo: instruction section position: instruction position + 1 offset: 1
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpIr8 >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 1
		and: [ anInstruction first isImmediate
		and: [ anInstruction first isImmediateS8RelativeTo: anInstruction position: anInstruction position offset: 1 + opcode size ] ]
]

{ #category : #testing }
SAsmX86InstructionOpIr8 >> canWriteShortInstruction: anInstruction [
	^ anInstruction argumentCount = 1
		and: [ anInstruction first isImmediateSymbolWithAddend ]
]

{ #category : #testing }
SAsmX86InstructionOpIr8 >> isShortBranchSpan: aBranchSpan [
	^ -128 <= aBranchSpan and: [ aBranchSpan <= 127 ]
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
