Class {
	#name : #SAsmConstantExpressionBinaryAdd,
	#superclass : #SAsmConstantExpressionBinary,
	#category : #'SAsm-Core-Generic'
}

{ #category : #'public access' }
SAsmConstantExpressionBinaryAdd >> evaluate [
	| leftValue rightValue |
	leftValue := left evaluateValue.
	rightValue := right evaluateValue.
	^ (leftValue + rightValue) asSAsmConstantExpression 
]

{ #category : #printing }
SAsmConstantExpressionBinaryAdd >> mnemonic [
	^ #+
]
