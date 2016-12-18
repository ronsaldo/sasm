Class {
	#name : #SAsmX86InstructionOpALI8,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionOpALI8 >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first = AL
		and: [ anInstruction second isImmediate8 ] ]
]

{ #category : #testing }
SAsmX86InstructionOpALI8 >> writeInstruction: instruction with: writer [
	writer nextPutAll: opcode.
	writer nextPutI8: instruction arguments second
]
