Class {
	#name : #SAsmTacComparisonIntegerBelow,
	#superclass : #SAsmTacComparisonInteger,
	#category : #'SAsm-Core-TAC'
}

{ #category : #printing }
SAsmTacComparisonIntegerBelow >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacBelow: aCondition withBranch: aBranch
]

{ #category : #printing }
SAsmTacComparisonIntegerBelow >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacBelow: anInstruction
]

{ #category : #printing }
SAsmTacComparisonIntegerBelow >> mnemonic [
	^ #'below'
]
