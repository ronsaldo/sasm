Class {
	#name : #SAsmTacMoveOperation,
	#superclass : #SAsmTacOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacMoveOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacMove: anInstruction
]

{ #category : #printing }
SAsmTacMoveOperation >> mnemonic [
	^ #move
]
