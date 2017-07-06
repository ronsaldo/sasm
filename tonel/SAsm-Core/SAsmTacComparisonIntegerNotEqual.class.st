Class {
	#name : #SAsmTacComparisonIntegerNotEqual,
	#superclass : #SAsmTacComparisonInteger,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerNotEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacNotEqual: aCondition withBranch: aBranch
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerNotEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacNotEqual: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerNotEqual >> mnemonic [
	^ #'~='
]
