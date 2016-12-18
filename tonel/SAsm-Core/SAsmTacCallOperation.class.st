Class {
	#name : #SAsmTacCallOperation,
	#superclass : #SAsmTacOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacCallOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacCall: anInstruction
]

{ #category : #printing }
SAsmTacCallOperation >> mnemonic [
	^ #call
]
