Class {
	#name : #SAsmTacLoadSignExtend16Operation,
	#superclass : #SAsmTacLoadOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacLoadSignExtend16Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLoadSignExtent16: anInstruction
]

{ #category : #printing }
SAsmTacLoadSignExtend16Operation >> mnemonic [
	^ #loads16
]
