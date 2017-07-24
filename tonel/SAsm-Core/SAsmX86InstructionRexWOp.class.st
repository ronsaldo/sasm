Class {
	#name : #SAsmX86InstructionRexWOp,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionRexWOp >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 0
]

{ #category : #accessing }
SAsmX86InstructionRexWOp >> maxSize [
	^ 1 + opcode size
]

{ #category : #writing }
SAsmX86InstructionRexWOp >> writeInstruction: instruction with: writer [
	self write: writer rexSize: 1.
	writer nextPutAll: opcode
]
