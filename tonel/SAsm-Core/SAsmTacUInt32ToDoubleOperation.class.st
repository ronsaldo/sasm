Class {
	#name : #SAsmTacUInt32ToDoubleOperation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacUInt32ToDoubleOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacUInt32ToDouble: anInstruction
]

{ #category : #printing }
SAsmTacUInt32ToDoubleOperation >> mnemonic [
	^ #uint32ToDouble
]
