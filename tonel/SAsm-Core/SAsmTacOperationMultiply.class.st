Class {
	#name : #SAsmTacOperationMultiply,
	#superclass : #SAsmTacArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationMultiply >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacMultiply: anInstruction
]

{ #category : #printing }
SAsmTacOperationMultiply >> mnemonic [
	^ #'*'
]
