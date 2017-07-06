Class {
	#name : #SAsmTacComparisonIntegerEqual,
	#superclass : #SAsmTacComparisonInteger,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacEqual: aCondition withBranch: aBranch
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacEqual: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerEqual >> mnemonic [
	^ #'=='
]
