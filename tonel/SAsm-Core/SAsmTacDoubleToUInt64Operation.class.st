Class {
	#name : #SAsmTacDoubleToUInt64Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacDoubleToUInt64Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacDoubleToUInt64: anInstruction
]

{ #category : #printing }
SAsmTacDoubleToUInt64Operation >> mnemonic [
	^ #double2uint64
]
