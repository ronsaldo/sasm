Class {
	#name : #SAsmTacOperationUDivide,
	#superclass : #SAsmTacArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationUDivide >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacUDivide: anInstruction
]

{ #category : #testing }
SAsmTacOperationUDivide >> isIntegerDivision [
	^ true
]

{ #category : #printing }
SAsmTacOperationUDivide >> mnemonic [
	^ #'udiv'
]
