Class {
	#name : #SAsmTacOperationFloatSqrt,
	#superclass : #SAsmTacFloatArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationFloatSqrt >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatSqrt: anInstruction
]

{ #category : #printing }
SAsmTacOperationFloatSqrt >> mnemonic [
	^ #floatSqrt
]
