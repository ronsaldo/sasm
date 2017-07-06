Class {
	#name : #SAsmTacComparisonFloatOrderedGreaterOrEqual,
	#superclass : #SAsmTacComparisonFloat,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonFloatOrderedGreaterOrEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacFloatOrderedGreaterOrEqual: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonFloatOrderedGreaterOrEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatOrderedGreaterOrEqual: anInstruction
]

{ #category : #printing }
SAsmTacComparisonFloatOrderedGreaterOrEqual >> mnemonic [
	^ #floatOrderedGreaterOrEqual
]
