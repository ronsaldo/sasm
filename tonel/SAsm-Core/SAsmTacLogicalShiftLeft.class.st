Class {
	#name : #SAsmTacLogicalShiftLeft,
	#superclass : #SAsmTacBitwiseOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacLogicalShiftLeft >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLogicalShiftLeft: anInstruction
]

{ #category : #printing }
SAsmTacLogicalShiftLeft >> mnemonic [
	^ #lshiftLeft
]
