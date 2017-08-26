Class {
	#name : #SAsmTacFloatToDoubleOperation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacFloatToDoubleOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatToDouble: anInstruction
]

{ #category : #printing }
SAsmTacFloatToDoubleOperation >> mnemonic [
	^ #float2double
]
