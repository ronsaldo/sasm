Class {
	#name : #SAsmTacBitXor,
	#superclass : #SAsmTacBitwiseOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacBitXor >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacBitXor: anInstruction
]

{ #category : #printing }
SAsmTacBitXor >> mnemonic [
	^ #bitXor
]
