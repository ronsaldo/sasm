Class {
	#name : #SAsmTacComparisonIntegerLessOrEqual,
	#superclass : #SAsmTacComparisonInteger,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerLessOrEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacLessOrEqual: aCondition withBranch: aBranch
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerLessOrEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLessOrEqual: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerLessOrEqual >> mnemonic [
	^ #'<='
]
