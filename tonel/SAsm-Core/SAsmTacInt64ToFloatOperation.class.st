Class {
	#name : #SAsmTacInt64ToFloatOperation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacInt64ToFloatOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacInt64ToFloat: anInstruction
]

{ #category : #printing }
SAsmTacInt64ToFloatOperation >> mnemonic [
	^ #int64ToFloat
]
