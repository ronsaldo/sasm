Class {
	#name : #SAsmTacFloatToUInt32Operation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacFloatToUInt32Operation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatToUInt32: anInstruction
]

{ #category : #printing }
SAsmTacFloatToUInt32Operation >> mnemonic [
	^ #float2uint32
]
