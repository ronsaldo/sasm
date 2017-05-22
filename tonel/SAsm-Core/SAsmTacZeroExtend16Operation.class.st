Class {
	#name : #SAsmTacZeroExtend16Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacZeroExtend16Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacZeroExtend16: anInstruction
]

{ #category : #printing }
SAsmTacZeroExtend16Operation >> mnemonic [
	^ #zext16
]
