Class {
	#name : #SAsmConstantExpressionConstantFloat,
	#superclass : #SAsmConstantExpressionConstant,
	#instVars : [
		'size'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #testing }
SAsmConstantExpressionConstantFloat >> isConstantExpressionConstantFloat [
	^ true
]

{ #category : #accessing }
SAsmConstantExpressionConstantFloat >> size [
	^ size
]

{ #category : #accessing }
SAsmConstantExpressionConstantFloat >> size: anObject [
	size := anObject
]
