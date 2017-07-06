Class {
	#name : #SAsmTacComparisonFloatOrderedNotEqual,
	#superclass : #SAsmTacComparisonFloat,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonFloatOrderedNotEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacFloatOrderedNotEqual: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonFloatOrderedNotEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatOrderedNotEqual: anInstruction
]

{ #category : #printing }
SAsmTacComparisonFloatOrderedNotEqual >> mnemonic [
	^ #floatOrderedNotEqual
]
