Class {
	#name : #SAsmTacUInt32ToFloatOperation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacUInt32ToFloatOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacUInt32ToFloat: anInstruction
]

{ #category : #printing }
SAsmTacUInt32ToFloatOperation >> mnemonic [
	^ #uint32ToFloat
]
