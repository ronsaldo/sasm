Class {
	#name : #SAsmTacRotateRight,
	#superclass : #SAsmTacBitwiseOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacRotateRight >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacRotateRight: anInstruction
]

{ #category : #printing }
SAsmTacRotateRight >> mnemonic [
	^ #rotateRight
]
