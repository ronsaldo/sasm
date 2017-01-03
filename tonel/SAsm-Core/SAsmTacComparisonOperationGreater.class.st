Class {
	#name : #SAsmTacComparisonOperationGreater,
	#superclass : #SAsmTacComparisonOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationGreater >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacGreater: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationGreater >> mnemonic [
	^ #'>'
]
