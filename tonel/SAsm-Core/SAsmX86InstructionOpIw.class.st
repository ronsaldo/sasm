Class {
	#name : #SAsmX86InstructionOpIw,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionOpIw >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 1
		and: [ anInstruction first isImmediate ]
]

{ #category : #testing }
SAsmX86InstructionOpIw >> writeInstruction: instruction with: writer [
	writer nextPutAll: opcode.
	writer isShortMode ifTrue: [ 
		writer nextPutI16: instruction arguments first
	] ifFalse: [ 
		writer isLongMode ifTrue: [ self assert: instruction arguments first isImmediateS32 ].
		writer nextPutI32: instruction arguments first
	]
]
