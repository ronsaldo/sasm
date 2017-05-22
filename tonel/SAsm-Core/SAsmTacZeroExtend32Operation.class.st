Class {
	#name : #SAsmTacZeroExtend32Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacZeroExtend32Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacZeroExtend32: anInstruction
]

{ #category : #printing }
SAsmTacZeroExtend32Operation >> mnemonic [
	^ #zext32
]
