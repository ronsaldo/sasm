Class {
	#name : #SAsmTacOperationFloatAdd,
	#superclass : #SAsmTacFloatArithmeticOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperationFloatAdd >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatAdd: anInstruction
]

{ #category : #printing }
SAsmTacOperationFloatAdd >> mnemonic [
	^ #floatAdd
]
