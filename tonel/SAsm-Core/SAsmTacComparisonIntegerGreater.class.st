Class {
	#name : #SAsmTacComparisonIntegerGreater,
	#superclass : #SAsmTacComparisonInteger,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerGreater >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacGreater: aCondition withBranch: aBranch
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerGreater >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacGreater: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacComparisonIntegerGreater >> mnemonic [
	^ #'>'
]
