Class {
	#name : #SAsmTacBitAnd,
	#superclass : #SAsmTacBitwiseOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacBitAnd >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacBitAnd: anInstruction
]

{ #category : #printing }
SAsmTacBitAnd >> mnemonic [
	^ #bitAnd
]
