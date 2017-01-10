Class {
	#name : #SAsmTacComparisonOperationNotEqual,
	#superclass : #SAsmTacComparisonOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationNotEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacNotEqual: aCondition withBranch: aBranch
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationNotEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacNotEqual: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonOperationNotEqual >> mnemonic [
	^ #'~='
]
