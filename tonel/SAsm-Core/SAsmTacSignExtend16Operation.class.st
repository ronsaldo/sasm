Class {
	#name : #SAsmTacSignExtend16Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacSignExtend16Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacSignExtend16: anInstruction
]

{ #category : #printing }
SAsmTacSignExtend16Operation >> mnemonic [
	^ #sext16
]
