Class {
	#name : #SAsmConstantExpressionSymbolValue,
	#superclass : #SAsmConstantExpression,
	#instVars : [
		'size',
		'symbol'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #copying }
SAsmConstantExpressionSymbolValue >> copyWithStreamBuilder: aStreamBuilder [
	^ self copy symbol: (symbol copyWithStreamBuilder: aStreamBuilder)
]

{ #category : #'public access' }
SAsmConstantExpressionSymbolValue >> evaluate [
	^ self
]

{ #category : #printing }
SAsmConstantExpressionSymbolValue >> fullPrintOn: aStream [
	symbol fullPrintOn: aStream
]

{ #category : #testing }
SAsmConstantExpressionSymbolValue >> isConstantExpressionSymbolValue [
	^ true
]

{ #category : #accessing }
SAsmConstantExpressionSymbolValue >> size [
	^ size
]

{ #category : #accessing }
SAsmConstantExpressionSymbolValue >> size: anObject [
	size := anObject
]

{ #category : #accessing }
SAsmConstantExpressionSymbolValue >> symbol [
	^ symbol
]

{ #category : #accessing }
SAsmConstantExpressionSymbolValue >> symbol: anObject [
	symbol := anObject
]

{ #category : #writing }
SAsmConstantExpressionSymbolValue >> writeWithSize: aSize on: writer [
	aSize = 2 ifTrue: [ ^ writer nextPutI16: symbol ].
	aSize = 4 ifTrue: [ ^ writer nextPutI32: symbol ].
	aSize = 8 ifTrue: [ ^ writer nextPutI64: symbol ].
	self error: 'Unsupported symbol size.'
]
