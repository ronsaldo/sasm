"
I encode X86 of the form:
Opcode, Unsigned Immediate 16
"
Class {
	#name : #SAsmX86InstructionOpU16,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionOpU16 >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 1 and: [ anInstruction first isImmediateU16 ]
]

{ #category : #accessing }
SAsmX86InstructionOpU16 >> maxSize [
	^ 3
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpU16 >> writeInstruction: instruction with: writer [
	writer nextPutAll: opcode; nextPutI16: instruction arguments first
]
