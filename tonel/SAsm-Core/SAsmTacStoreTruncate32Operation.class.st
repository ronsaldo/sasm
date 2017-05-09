Class {
	#name : #SAsmTacStoreTruncate32Operation,
	#superclass : #SAsmTacStoreOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacStoreTruncate32Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacStoreTruncate32: anInstruction
]

{ #category : #printing }
SAsmTacStoreTruncate32Operation >> mnemonic [
	^ #storeu32
]
