Class {
	#name : #SAsmTacComparisonIntegerBelowOrEqual,
	#superclass : #SAsmTacComparisonInteger,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonIntegerBelowOrEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacBelowOrEqual: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonIntegerBelowOrEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacBelowOrEqual: anInstruction
]

{ #category : #visiting }
SAsmTacComparisonIntegerBelowOrEqual >> mnemonic [
	^ #'belowOrEqual'
]
