Class {
	#name : #SAsmTacArithmeticShiftRight,
	#superclass : #SAsmTacBitwiseOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacArithmeticShiftRight >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacArithmeticShiftRight: anInstruction
]

{ #category : #printing }
SAsmTacArithmeticShiftRight >> mnemonic [
	^ #ashiftRight
]
