Class {
	#name : #SAsmTacLoadDoubleOperation,
	#superclass : #SAsmTacLoadOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacLoadDoubleOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLoadDouble: anInstruction
]

{ #category : #printing }
SAsmTacLoadDoubleOperation >> mnemonic [
	^ #loadd
]
