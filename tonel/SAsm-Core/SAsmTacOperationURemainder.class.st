Class {
	#name : #SAsmTacOperationURemainder,
	#superclass : #SAsmTacIntegerArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationURemainder >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacURemainder: anInstruction
]

{ #category : #testing }
SAsmTacOperationURemainder >> isIntegerRemainder [
	^ true
]

{ #category : #printing }
SAsmTacOperationURemainder >> mnemonic [
	^ #'urem'
]
