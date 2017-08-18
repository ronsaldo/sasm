Class {
	#name : #SAsmX86InstructionOpBranch32,
	#superclass : #SAsmX86InstructionOpIrw,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #writing }
SAsmX86InstructionOpBranch32 >> writeInstruction: instruction with: writer [
	writer nextPutAll: opcode.
	writer isShortMode ifTrue: [ 
		writer nextPutIPRelativeI16: instruction arguments first
	] ifFalse: [
		writer nextPutIPRelativeBranch32: instruction arguments first
	]
]
