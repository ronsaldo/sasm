Class {
	#name : #SAsmTacReturnOperation,
	#superclass : #SAsmTacOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacReturnOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacReturn: anInstruction
]

{ #category : #testing }
SAsmTacReturnOperation >> isReturn [
	^ true
]

{ #category : #printing }
SAsmTacReturnOperation >> mnemonic [
	^ #return
]
