Class {
	#name : #SAsmTacOperationFloatNegate,
	#superclass : #SAsmTacFloatArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationFloatNegate >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatNegate: anInstruction
]

{ #category : #printing }
SAsmTacOperationFloatNegate >> mnemonic [
	^ #floatNegate
]
