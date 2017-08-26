Class {
	#name : #SAsmTacInt32ToFloatOperation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacInt32ToFloatOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacInt32ToFloat: anInstruction
]

{ #category : #printing }
SAsmTacInt32ToFloatOperation >> mnemonic [
	^ #int32ToFloat
]
