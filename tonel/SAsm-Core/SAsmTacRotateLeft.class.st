Class {
	#name : #SAsmTacRotateLeft,
	#superclass : #SAsmTacBitwiseOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacRotateLeft >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacRotateLeft: anInstruction
]

{ #category : #printing }
SAsmTacRotateLeft >> mnemonic [
	^ #rotateLeft
]
