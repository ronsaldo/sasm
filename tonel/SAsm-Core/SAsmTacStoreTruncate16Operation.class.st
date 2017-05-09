Class {
	#name : #SAsmTacStoreTruncate16Operation,
	#superclass : #SAsmTacStoreOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacStoreTruncate16Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacStoreTruncate16: anInstruction
]

{ #category : #printing }
SAsmTacStoreTruncate16Operation >> mnemonic [
	^ #storeu16
]
