Class {
	#name : #SAsmTacAtomicFetchAndAdd,
	#superclass : #SAsmTacAtomicOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacAtomicFetchAndAdd >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacAtomicFetchAndAdd: anInstruction
]

{ #category : #printing }
SAsmTacAtomicFetchAndAdd >> mnemonic [
	^ #fetchadd
]
