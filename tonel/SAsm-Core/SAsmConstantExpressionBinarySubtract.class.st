Class {
	#name : #SAsmConstantExpressionBinarySubtract,
	#superclass : #SAsmConstantExpressionBinary,
	#category : #'SAsm-Core-Generic'
}

{ #category : #'public access' }
SAsmConstantExpressionBinarySubtract >> evaluate [
	| leftValue rightValue |
	leftValue := left evaluateValue.
	rightValue := right evaluateValue.
	^ (leftValue - rightValue) asSAsmConstantExpression 
]

{ #category : #printing }
SAsmConstantExpressionBinarySubtract >> mnemonic [
	^ #-
]
