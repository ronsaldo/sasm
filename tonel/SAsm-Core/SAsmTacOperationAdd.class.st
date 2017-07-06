Class {
	#name : #SAsmTacOperationAdd,
	#superclass : #SAsmTacIntegerArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationAdd >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacAdd: anInstruction
]

{ #category : #printing }
SAsmTacOperationAdd >> mnemonic [
	^ #'+'
]
