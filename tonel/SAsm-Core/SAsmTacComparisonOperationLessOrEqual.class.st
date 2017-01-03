Class {
	#name : #SAsmTacComparisonOperationLessOrEqual,
	#superclass : #SAsmTacComparisonOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationLessOrEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLessOrEqual: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationLessOrEqual >> mnemonic [
	^ #'<='
]