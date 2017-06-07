Class {
	#name : #SAsmTacOperationUDivide,
	#superclass : #SAsmTacArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationUDivide >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacUDivide: anInstruction
]

{ #category : #printing }
SAsmTacOperationUDivide >> mnemonic [
	^ #'udiv'
]
