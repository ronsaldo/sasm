Class {
	#name : #SAsmTacAtomicSwap,
	#superclass : #SAsmTacAtomicOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacAtomicSwap >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacAtomicSwap: anInstruction
]

{ #category : #printing }
SAsmTacAtomicSwap >> mnemonic [
	^ #swap
]
