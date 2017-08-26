Class {
	#name : #SAsmTacUInt64ToDoubleOperation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacUInt64ToDoubleOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacUInt64ToDouble: anInstruction
]

{ #category : #printing }
SAsmTacUInt64ToDoubleOperation >> mnemonic [
	^ #uint64ToDouble
]
