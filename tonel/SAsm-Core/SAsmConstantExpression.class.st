Class {
	#name : #SAsmConstantExpression,
	#superclass : #Object,
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
