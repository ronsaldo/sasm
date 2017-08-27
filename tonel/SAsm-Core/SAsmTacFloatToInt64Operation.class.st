Class {
	#name : #SAsmTacFloatToInt64Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacFloatToInt64Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatToInt64: anInstruction
]

{ #category : #printing }
SAsmTacFloatToInt64Operation >> mnemonic [
	^ #float2int64
]
