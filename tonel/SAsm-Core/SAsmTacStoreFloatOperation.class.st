Class {
	#name : #SAsmTacStoreFloatOperation,
	#superclass : #SAsmTacStoreOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacStoreFloatOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacStoreFloat: anInstruction
]

{ #category : #printing }
SAsmTacStoreFloatOperation >> mnemonic [
	^ #storef
]
