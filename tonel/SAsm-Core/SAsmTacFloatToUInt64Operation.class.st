Class {
	#name : #SAsmTacFloatToUInt64Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacFloatToUInt64Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatToUInt64: anInstruction
]

{ #category : #printing }
SAsmTacFloatToUInt64Operation >> mnemonic [
	^ #float2uint64
]
