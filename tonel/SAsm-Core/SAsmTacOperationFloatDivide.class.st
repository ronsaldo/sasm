Class {
	#name : #SAsmTacOperationFloatDivide,
	#superclass : #SAsmTacFloatArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationFloatDivide >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatDivide: anInstruction
]

{ #category : #printing }
SAsmTacOperationFloatDivide >> mnemonic [
	^ #floatDivide
]
