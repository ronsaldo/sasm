Class {
	#name : #SAsmTacZeroExtend8Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacZeroExtend8Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacZeroExtend8: anInstruction
]

{ #category : #printing }
SAsmTacZeroExtend8Operation >> mnemonic [
	^ #zext8
]
