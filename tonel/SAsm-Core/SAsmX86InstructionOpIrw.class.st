Class {
	#name : #SAsmX86InstructionOpIrw,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionOpIrw >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 1
		and: [ anInstruction first isImmediate ]
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpIrw >> writeInstruction: instruction with: writer [
	writer nextPutAll: opcode.
	writer isShortMode ifTrue: [ 
		writer nextPutIPRelativeI16: instruction arguments first
	] ifFalse: [
		writer nextPutIPRelativeI32: instruction arguments first
	]
]
