Class {
	#name : #SAsmTacLoadOperation,
	#superclass : #SAsmTacOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacLoadOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLoad: anInstruction
]

{ #category : #printing }
SAsmTacLoadOperation >> mnemonic [
	^ #load
]
