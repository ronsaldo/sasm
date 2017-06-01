Class {
	#name : #SAsmConstantExpression,
	#superclass : #SAsmObject,
	#category : #'SAsm-Core-Generic'
}

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
