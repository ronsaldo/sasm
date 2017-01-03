Class {
	#name : #SAsmTacComparisonOperationEqual,
	#superclass : #SAsmTacComparisonOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacEqual: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationEqual >> mnemonic [
	^ #'=='
]