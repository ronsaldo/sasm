Class {
	#name : #SAsmTacComparisonIntegerLess,
	#superclass : #SAsmTacComparisonInteger,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerLess >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacLess: aCondition withBranch: aBranch
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerLess >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLess: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerLess >> mnemonic [
	^ #'<'
]
