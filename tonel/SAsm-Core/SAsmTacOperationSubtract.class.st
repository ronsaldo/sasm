Class {
	#name : #SAsmTacOperationSubtract,
	#superclass : #SAsmTacIntegerArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationSubtract >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacSubtract: anInstruction
]

{ #category : #printing }
SAsmTacOperationSubtract >> mnemonic [
	^ #'-'
]
