Class {
	#name : #SAsmTacOperationFloatSubtract,
	#superclass : #SAsmTacFloatArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationFloatSubtract >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatSubtract: anInstruction
]

{ #category : #visiting }
SAsmTacOperationFloatSubtract >> mnemonic [
	^ #floatSubtract
]
