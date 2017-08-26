Class {
	#name : #SAsmTacInt32ToDoubleOperation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacInt32ToDoubleOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacInt32ToDouble: anInstruction
]

{ #category : #printing }
SAsmTacInt32ToDoubleOperation >> mnemonic [
	^ #int32ToDouble
]
