Class {
	#name : #SAsmConstantExpressionBinary,
	#superclass : #SAsmConstantExpression,
	#instVars : [
		'left',
		'right'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'initialize-release' }
SAsmConstantExpressionBinary class >> left: left right: right [
	^ self new left: left; right: right; yourself
]

{ #category : #copying }
SAsmConstantExpressionBinary >> copyWithStreamBuilder: aStreamBuilder [
	^ self copy
		left: (left copyWithStreamBuilder: aStreamBuilder);
		right: (right copyWithStreamBuilder: aStreamBuilder)
]

{ #category : #accessing }
SAsmConstantExpressionBinary >> left [
	^ left
]

{ #category : #accessing }
SAsmConstantExpressionBinary >> left: anObject [
	left := anObject
]

{ #category : #printing }
SAsmConstantExpressionBinary >> mnemonic [
	self subclassResponsibility
]

{ #category : #printing }
SAsmConstantExpressionBinary >> printOn: aStream [
	aStream nextPut: $( ; print: left; space; nextPutAll: self mnemonic; space; print: right; nextPut: $)
]

{ #category : #accessing }
SAsmConstantExpressionBinary >> right [
	^ right
]

{ #category : #accessing }
SAsmConstantExpressionBinary >> right: anObject [
	right := anObject
]
