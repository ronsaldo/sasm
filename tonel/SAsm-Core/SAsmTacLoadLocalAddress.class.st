Class {
	#name : #SAsmTacLoadLocalAddress,
	#superclass : #SAsmTacOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #printing }
SAsmTacLoadLocalAddress >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLoadLocalAddress: anInstruction
]

{ #category : #printing }
SAsmTacLoadLocalAddress >> mnemonic [
	^ #loadLocalAddress
]
