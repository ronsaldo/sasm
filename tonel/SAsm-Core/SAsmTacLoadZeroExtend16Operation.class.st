Class {
	#name : #SAsmTacLoadZeroExtend16Operation,
	#superclass : #SAsmTacLoadOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacLoadZeroExtend16Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLoadZeroExtend16: anInstruction
]

{ #category : #printing }
SAsmTacLoadZeroExtend16Operation >> mnemonic [
	^ #loadz16
]
