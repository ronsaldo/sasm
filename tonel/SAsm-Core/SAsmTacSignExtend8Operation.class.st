Class {
	#name : #SAsmTacSignExtend8Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacSignExtend8Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacSignExtend8: anInstruction
]

{ #category : #printing }
SAsmTacSignExtend8Operation >> mnemonic [
	^ #sext8
]
