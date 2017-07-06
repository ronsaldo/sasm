Class {
	#name : #SAsmTacOperationRemainder,
	#superclass : #SAsmTacIntegerArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationRemainder >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacRemainder: anInstruction
]

{ #category : #testing }
SAsmTacOperationRemainder >> isIntegerRemainder [
	^ true
]

{ #category : #printing }
SAsmTacOperationRemainder >> mnemonic [
	^ #'rem'
]
