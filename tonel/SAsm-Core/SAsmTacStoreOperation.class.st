Class {
	#name : #SAsmTacStoreOperation,
	#superclass : #SAsmTacOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacStoreOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacStore: anInstruction
]

{ #category : #printing }
SAsmTacStoreOperation >> mnemonic [
	^ #store
]
