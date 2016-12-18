Class {
	#name : #SAsmConstantExpressionConstant,
	#superclass : #SAsmConstantExpression,
	#instVars : [
		'value'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'public access' }
SAsmConstantExpressionConstant >> evaluate [
	^ self
]

{ #category : #printing }
SAsmConstantExpressionConstant >> fullPrintOn: aStream [
	aStream putNumber: value
]

{ #category : #accessing }
SAsmConstantExpressionConstant >> value [
	^ value
]

{ #category : #accessing }
SAsmConstantExpressionConstant >> value: anObject [
	value := anObject
]

{ #category : #'as yet unclassified' }
SAsmConstantExpressionConstant >> writeWithSize: size on: writer [
	self subclassResponsibility
]
