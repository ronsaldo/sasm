Class {
	#name : #SAsmTacBitOr,
	#superclass : #SAsmTacBitwiseOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacBitOr >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacBitOr: anInstruction
]

{ #category : #printing }
SAsmTacBitOr >> mnemonic [
	^ #bitOr
]
