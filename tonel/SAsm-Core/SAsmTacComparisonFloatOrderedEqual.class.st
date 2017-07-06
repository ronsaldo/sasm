Class {
	#name : #SAsmTacComparisonFloatOrderedEqual,
	#superclass : #SAsmTacComparisonFloat,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonFloatOrderedEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacFloatOrderedEqual: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonFloatOrderedEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatOrderedEqual: anInstruction
]

{ #category : #printing }
SAsmTacComparisonFloatOrderedEqual >> mnemonic [
	^ #floatOrderedEqual
]
