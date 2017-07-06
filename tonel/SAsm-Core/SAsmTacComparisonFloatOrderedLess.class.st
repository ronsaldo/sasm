Class {
	#name : #SAsmTacComparisonFloatOrderedLess,
	#superclass : #SAsmTacComparisonFloat,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonFloatOrderedLess >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacFloatOrderedLess: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonFloatOrderedLess >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatOrderedLess: anInstruction
]

{ #category : #printing }
SAsmTacComparisonFloatOrderedLess >> mnemonic [
	^ #floatOrderedLess
]
