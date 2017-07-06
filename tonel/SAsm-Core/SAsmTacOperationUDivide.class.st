Class {
	#name : #SAsmTacOperationUDivide,
	#superclass : #SAsmTacIntegerArithmeticOperation,
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
