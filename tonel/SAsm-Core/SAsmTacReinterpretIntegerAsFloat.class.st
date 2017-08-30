Class {
	#name : #SAsmTacReinterpretIntegerAsFloat,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacReinterpretIntegerAsFloat >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacReinterpretIntegerAsFloat: anInstruction
]

{ #category : #visiting }
SAsmTacReinterpretIntegerAsFloat >> mnemonic [
	^ #reintepretIntegerAsFloat
]
