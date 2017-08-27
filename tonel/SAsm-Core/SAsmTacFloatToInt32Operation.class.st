Class {
	#name : #SAsmTacFloatToInt32Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacFloatToInt32Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatToInt32: anInstruction
]

{ #category : #printing }
SAsmTacFloatToInt32Operation >> mnemonic [
	^ #float2int32
]
