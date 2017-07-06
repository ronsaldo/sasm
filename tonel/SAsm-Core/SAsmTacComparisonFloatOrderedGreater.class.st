Class {
	#name : #SAsmTacComparisonFloatOrderedGreater,
	#superclass : #SAsmTacComparisonFloat,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonFloatOrderedGreater >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacFloatOrderedGreater: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonFloatOrderedGreater >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatOrderedGreater: anInstruction
]

{ #category : #printing }
SAsmTacComparisonFloatOrderedGreater >> mnemonic [
	^ #floatOrderedGreater
]
