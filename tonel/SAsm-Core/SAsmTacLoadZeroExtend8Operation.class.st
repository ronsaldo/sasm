Class {
	#name : #SAsmTacLoadZeroExtend8Operation,
	#superclass : #SAsmTacLoadOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacLoadZeroExtend8Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLoadZeroExtend8: anInstruction
]

{ #category : #printing }
SAsmTacLoadZeroExtend8Operation >> mnemonic [
	^ #loadz8
]
