Class {
	#name : #SAsmTacComparisonIntegerGreaterOrEqual,
	#superclass : #SAsmTacComparisonInteger,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerGreaterOrEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacGreaterOrEqual: aCondition withBranch: aBranch
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerGreaterOrEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacGreaterOrEqual: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerGreaterOrEqual >> mnemonic [
	^ #'>='
]
