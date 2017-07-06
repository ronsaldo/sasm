Class {
	#name : #SAsmTacComparisonFloatUnorderedLess,
	#superclass : #SAsmTacComparisonFloat,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonFloatUnorderedLess >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacFloatUnorderedLess: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonFloatUnorderedLess >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatUnorderedLess: anInstruction
]

{ #category : #printing }
SAsmTacComparisonFloatUnorderedLess >> mnemonic [
	^ #floatUnorderedLess
]
