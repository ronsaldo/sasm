Class {
	#name : #SAsmTacStoreDoubleOperation,
	#superclass : #SAsmTacStoreOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacStoreDoubleOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacStoreDouble: anInstruction
]

{ #category : #printing }
SAsmTacStoreDoubleOperation >> mnemonic [
	^ #stored
]
