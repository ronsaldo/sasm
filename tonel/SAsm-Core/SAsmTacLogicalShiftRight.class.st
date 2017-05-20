Class {
	#name : #SAsmTacLogicalShiftRight,
	#superclass : #SAsmTacBitwiseOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacLogicalShiftRight >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLogicalShiftRight: anInstruction
]

{ #category : #printing }
SAsmTacLogicalShiftRight >> mnemonic [
	^ #lshiftRight
]
