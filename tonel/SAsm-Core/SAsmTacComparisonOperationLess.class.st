Class {
	#name : #SAsmTacComparisonOperationLess,
	#superclass : #SAsmTacComparisonOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationLess >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLess: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationLess >> mnemonic [
	^ #'<'
]
