Class {
	#name : #SAsmTacOperationURemainder,
	#superclass : #SAsmTacArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationURemainder >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacURemainder: anInstruction
]

{ #category : #printing }
SAsmTacOperationURemainder >> mnemonic [
	^ #'urem'
]
