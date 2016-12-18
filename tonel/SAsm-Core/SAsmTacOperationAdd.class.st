Class {
	#name : #SAsmTacOperationAdd,
	#superclass : #SAsmTacArithmeticOperation,
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
