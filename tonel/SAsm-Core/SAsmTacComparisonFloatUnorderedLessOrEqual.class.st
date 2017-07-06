Class {
	#name : #SAsmTacComparisonFloatUnorderedLessOrEqual,
	#superclass : #SAsmTacComparisonFloat,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonFloatUnorderedLessOrEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacFloatUnorderedLessOrEqual: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonFloatUnorderedLessOrEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatUnorderedLessOrEqual: anInstruction
]

{ #category : #printing }
SAsmTacComparisonFloatUnorderedLessOrEqual >> mnemonic [
	^ #floatUnorderedLessOrEqual
]
