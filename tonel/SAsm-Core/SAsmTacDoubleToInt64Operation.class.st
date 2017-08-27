Class {
	#name : #SAsmTacDoubleToInt64Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacDoubleToInt64Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacDoubleToInt64: anInstruction
]

{ #category : #printing }
SAsmTacDoubleToInt64Operation >> mnemonic [
	^ #double2int64
]
