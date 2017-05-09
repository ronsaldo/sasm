Class {
	#name : #SAsmTacStoreTruncate8Operation,
	#superclass : #SAsmTacStoreOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacStoreTruncate8Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacStoreTruncate8: anInstruction
]

{ #category : #printing }
SAsmTacStoreTruncate8Operation >> mnemonic [
	^ #storeu8
]
