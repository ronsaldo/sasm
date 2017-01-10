Class {
	#name : #SAsmTacComparisonOperationLess,
	#superclass : #SAsmTacComparisonOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationLess >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacLess: aCondition withBranch: aBranch
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationLess >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLess: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationLess >> mnemonic [
	^ #'<'
]
