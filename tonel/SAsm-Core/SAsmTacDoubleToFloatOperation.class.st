Class {
	#name : #SAsmTacDoubleToFloatOperation,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacDoubleToFloatOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacDoubleToFloat: anInstruction
]

{ #category : #printing }
SAsmTacDoubleToFloatOperation >> mnemonic [
	^ #double2float
]
