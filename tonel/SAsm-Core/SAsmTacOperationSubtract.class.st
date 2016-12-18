Class {
	#name : #SAsmTacOperationSubtract,
	#superclass : #SAsmTacArithmeticOperation,
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
