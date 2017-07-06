Class {
	#name : #SAsmTacComparisonFloatUnorderedGreater,
	#superclass : #SAsmTacComparisonFloat,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacComparisonFloatUnorderedGreater >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	^ aVisitor visitTacFloatUnorderedGreater: aCondition withBranch: aBranch
]

{ #category : #visiting }
SAsmTacComparisonFloatUnorderedGreater >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacFloatUnorderedGreater: anInstruction
]

{ #category : #printing }
SAsmTacComparisonFloatUnorderedGreater >> mnemonic [
	^ #floatUnorderedGreater
]
