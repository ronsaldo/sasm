Class {
	#name : #SAsmTacAtomicCompareAndSwap,
	#superclass : #SAsmTacAtomicOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacAtomicCompareAndSwap >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacCompareAndSwap: anInstruction
]

{ #category : #printing }
SAsmTacAtomicCompareAndSwap >> mnemonic [
	^ #cmpswap
]
