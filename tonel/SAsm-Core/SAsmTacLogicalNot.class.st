Class {
	#name : #SAsmTacLogicalNot,
	#superclass : #SAsmTacBitwiseOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacLogicalNot >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLogicalNot: anInstruction
]

{ #category : #visiting }
SAsmTacLogicalNot >> mnemonic [
	^ #lnot
]
