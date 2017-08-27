Class {
	#name : #SAsmTacDoubleToInt32Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacDoubleToInt32Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacDoubleToInt32: anInstruction
]

{ #category : #printing }
SAsmTacDoubleToInt32Operation >> mnemonic [
	^ #double2int32
]
