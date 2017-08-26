Class {
	#name : #SAsmTacUInt64ToFloatOperation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacUInt64ToFloatOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacUInt64ToFloat: anInstruction
]

{ #category : #printing }
SAsmTacUInt64ToFloatOperation >> mnemonic [
	^ #uint64ToFloat
]
