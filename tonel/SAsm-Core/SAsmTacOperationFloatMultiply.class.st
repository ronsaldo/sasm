Class {
	#name : #SAsmTacOperationFloatMultiply,
	#superclass : #SAsmTacFloatArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationFloatMultiply >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatMultiply: anInstruction
]

{ #category : #printing }
SAsmTacOperationFloatMultiply >> mnemonic [
	^ #floatMultiply
]
