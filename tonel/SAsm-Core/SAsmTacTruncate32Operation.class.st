Class {
	#name : #SAsmTacTruncate32Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacTruncate32Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacTruncate32: anInstruction
]

{ #category : #printing }
SAsmTacTruncate32Operation >> mnemonic [
	^ #trunc32
]
