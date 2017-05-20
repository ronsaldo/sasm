Class {
	#name : #SAsmTacBitNot,
	#superclass : #SAsmTacBitwiseOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacBitNot >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacBitNot: anInstruction
]

{ #category : #printing }
SAsmTacBitNot >> mnemonic [
	^ #bitNot
]
