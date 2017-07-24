"
I encode X86 of the form:
Opcode
"
Class {
	#name : #SAsmX86InstructionOp,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionOp >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 0
]

{ #category : #accessing }
SAsmX86InstructionOp >> maxSize [
	^ opcode size
]

{ #category : #writing }
SAsmX86InstructionOp >> writeInstruction: instruction with: writer [
	writer nextPutAll: opcode
]
