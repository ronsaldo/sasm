Class {
	#name : #SAsmTacTruncate16Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacTruncate16Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacTruncate16: anInstruction
]

{ #category : #printing }
SAsmTacTruncate16Operation >> mnemonic [
	^ #trunc16
]
