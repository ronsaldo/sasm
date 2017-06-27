Class {
	#name : #SAsmTacContextReplaceFunctionOperation,
	#superclass : #SAsmTacContextOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #printing }
SAsmTacContextReplaceFunctionOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacContextReplaceFunction: anInstruction
]

{ #category : #printing }
SAsmTacContextReplaceFunctionOperation >> mnemonic [
	^ #contextReplaceFunction
]
