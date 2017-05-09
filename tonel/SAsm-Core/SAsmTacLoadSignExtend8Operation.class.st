Class {
	#name : #SAsmTacLoadSignExtend8Operation,
	#superclass : #SAsmTacLoadOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacLoadSignExtend8Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLoadSignExtend8: anInstruction
]

{ #category : #printing }
SAsmTacLoadSignExtend8Operation >> mnemonic [
	^ #loads8
]
