Class {
	#name : #SAsmTacOperationDivide,
	#superclass : #SAsmTacIntegerArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationDivide >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacDivide: anInstruction
]

{ #category : #testing }
SAsmTacOperationDivide >> isIntegerDivision [
	^ true
]

{ #category : #printing }
SAsmTacOperationDivide >> mnemonic [
	^ #'/'
]
