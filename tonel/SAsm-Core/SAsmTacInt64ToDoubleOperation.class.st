Class {
	#name : #SAsmTacInt64ToDoubleOperation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacInt64ToDoubleOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacInt64ToDouble: anInstruction
]

{ #category : #printing }
SAsmTacInt64ToDoubleOperation >> mnemonic [
	^ #int64ToDouble
]
