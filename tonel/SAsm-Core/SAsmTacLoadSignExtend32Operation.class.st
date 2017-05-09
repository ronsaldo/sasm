Class {
	#name : #SAsmTacLoadSignExtend32Operation,
	#superclass : #SAsmTacLoadOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacLoadSignExtend32Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLoadSignExtent32: anInstruction
]

{ #category : #printing }
SAsmTacLoadSignExtend32Operation >> mnemonic [
	^ #loads32
]
