Class {
	#name : #SAsmTacDoubleToUInt32Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacDoubleToUInt32Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacDoubleToUInt32: anInstruction
]

{ #category : #printing }
SAsmTacDoubleToUInt32Operation >> mnemonic [
	^ #double2uint32
]
