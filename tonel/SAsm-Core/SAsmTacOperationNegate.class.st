Class {
	#name : #SAsmTacOperationNegate,
	#superclass : #SAsmTacArithmeticOperation,
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
