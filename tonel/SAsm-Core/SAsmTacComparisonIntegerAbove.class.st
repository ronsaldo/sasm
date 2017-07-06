Class {
	#name : #SAsmTacComparisonIntegerAbove,
	#superclass : #SAsmTacComparisonInteger,
	#category : #'SAsm-Core-TAC'
}

{ #category : #printing }
SAsmTacComparisonIntegerAbove >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacAbove: aCondition withBranch: aBranch
]

{ #category : #printing }
SAsmTacComparisonIntegerAbove >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacAbove: anInstruction
]

{ #category : #printing }
SAsmTacComparisonIntegerAbove >> mnemonic [
	^ #'above'
]
