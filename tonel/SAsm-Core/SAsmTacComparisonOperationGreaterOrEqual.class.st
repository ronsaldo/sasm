Class {
	#name : #SAsmTacComparisonOperationGreaterOrEqual,
	#superclass : #SAsmTacComparisonOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationGreaterOrEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacGreaterOrEqual: aCondition withBranch: aBranch
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationGreaterOrEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacGreaterOrEqual: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationGreaterOrEqual >> mnemonic [
	^ #'>='
]
