Class {
	#name : #SAsmTacComparisonIntegerAboveOrEqual,
	#superclass : #SAsmTacComparisonInteger,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonIntegerAboveOrEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacAboveOrEqual: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonIntegerAboveOrEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacAboveOrEqual: anInstruction
]

{ #category : #visiting }
SAsmTacComparisonIntegerAboveOrEqual >> mnemonic [
	^ #'aboveOrEqual'
]
