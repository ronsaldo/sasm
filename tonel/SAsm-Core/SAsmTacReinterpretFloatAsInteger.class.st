Class {
	#name : #SAsmTacReinterpretFloatAsInteger,
	#superclass : #SAsmTacConvertionOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacReinterpretFloatAsInteger >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacReinterpretFloatAsInteger: anInstruction
]

{ #category : #printing }
SAsmTacReinterpretFloatAsInteger >> mnemonic [
	^ #reintepretFloatAsInteger
]
