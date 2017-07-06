Class {
	#name : #SAsmTacComparisonFloatUnorderedEqual,
	#superclass : #SAsmTacComparisonFloat,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonFloatUnorderedEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacFloatUnorderedEqual: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonFloatUnorderedEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatUnorderedEqual: anInstruction
]

{ #category : #printing }
SAsmTacComparisonFloatUnorderedEqual >> mnemonic [
	^ #floatUnorderedEqual
]
