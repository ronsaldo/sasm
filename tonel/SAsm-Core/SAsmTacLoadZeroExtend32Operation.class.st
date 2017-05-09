Class {
	#name : #SAsmTacLoadZeroExtend32Operation,
	#superclass : #SAsmTacLoadOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacLoadZeroExtend32Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLoadZeroExtend32: anInstruction
]

{ #category : #printing }
SAsmTacLoadZeroExtend32Operation >> mnemonic [
	^ #loadz32
]
