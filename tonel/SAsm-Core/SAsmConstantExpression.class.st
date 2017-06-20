Class {
	#name : #SAsmConstantExpression,
	#superclass : #SAsmObject,
	#category : #'SAsm-Core-Generic'
}

{ #category : #arithmetic }
SAsmConstantExpression >> + other [
	^ SAsmConstantExpressionBinaryAdd left: self right: other asSAsmConstantExpression
]

{ #category : #arithmetic }
SAsmConstantExpression >> - other [
	^ SAsmConstantExpressionBinarySubtract left: self right: other asSAsmConstantExpression
]

{ #category : #'as yet unclassified' }
SAsmConstantExpression >> asSAsmConstantExpression [
	^ self
]

{ #category : #converting }
SAsmConstantExpression >> asSAsmStreamElement [
	^ SAsmConstantExpressionValue new
		size: self size;
		value: self;
		yourself
]

{ #category : #copying }
SAsmConstantExpression >> copyWithStreamBuilder: aStreamBuilder [
	self subclassResponsibility
	
]

{ #category : #'public access' }
SAsmConstantExpression >> evaluate [
	^ self subclassResponsibility
]

{ #category : #'public access' }
SAsmConstantExpression >> evaluateValue [
	^ self evaluate
]

{ #category : #testing }
SAsmConstantExpression >> isConstantExpressionConstantFloat [
	^ false
]

{ #category : #testing }
SAsmConstantExpression >> isConstantExpressionConstantInteger [
	^ false
]

{ #category : #testing }
SAsmConstantExpression >> isConstantExpressionSymbolValue [
	^ false
]

{ #category : #testing }
SAsmConstantExpression >> isSAsmConstantExpression [
	^ true
]
