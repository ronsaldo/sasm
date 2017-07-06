Class {
	#name : #SAsmTacComparisonFloatUnorderedNotEqual,
	#superclass : #SAsmTacComparisonFloat,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonFloatUnorderedNotEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacFloatUnorderedNotEqual: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonFloatUnorderedNotEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatUnorderedNotEqual: anInstruction
]

{ #category : #printing }
SAsmTacComparisonFloatUnorderedNotEqual >> mnemonic [
	^ #floatUnorderedNotEqual
]
