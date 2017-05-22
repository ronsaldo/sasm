Class {
	#name : #SAsmTacSignExtend32Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacSignExtend32Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacSignExtend32: anInstruction
]

{ #category : #printing }
SAsmTacSignExtend32Operation >> mnemonic [
	^ #sext32
]
