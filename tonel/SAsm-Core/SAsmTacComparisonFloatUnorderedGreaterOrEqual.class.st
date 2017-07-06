Class {
	#name : #SAsmTacComparisonFloatUnorderedGreaterOrEqual,
	#superclass : #SAsmTacComparisonFloat,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonFloatUnorderedGreaterOrEqual >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacFloatUnorderedGreaterOrEqual: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonFloatUnorderedGreaterOrEqual >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatUnorderedGreaterOrEqual: anInstruction
]

{ #category : #printing }
SAsmTacComparisonFloatUnorderedGreaterOrEqual >> mnemonic [
	^ #floatUnorderedGreaterOrEqual
]
