Class {
	#name : #SAsmTacComparisonFloatOrderedLessOrEqual,
	#superclass : #SAsmTacComparisonFloat,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonFloatOrderedLessOrEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacFloatOrderedLessOrEqual: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonFloatOrderedLessOrEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatOrderedLessOrEqual: anInstruction
]

{ #category : #printing }
SAsmTacComparisonFloatOrderedLessOrEqual >> mnemonic [
	^ #floatOrderedLessOrEqual
]
