Class {
	#name : #SAsmTacTruncate8Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacTruncate8Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacTruncate8: anInstruction
]

{ #category : #printing }
SAsmTacTruncate8Operation >> mnemonic [
	^ #trunc8
]
