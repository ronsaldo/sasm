Class {
	#name : #SAsmTacOperationNegate,
	#superclass : #SAsmTacIntegerArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationNegate >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacNegate: anInstruction
]

{ #category : #printing }
SAsmTacOperationNegate >> mnemonic [
	^ #negate
]
