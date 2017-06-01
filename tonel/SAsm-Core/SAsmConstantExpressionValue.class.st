Class {
	#name : #SAsmConstantExpressionValue,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'size',
		'value'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #visiting }
SAsmConstantExpressionValue >> accept: aVisitor [
	^ aVisitor visitConstantExpressionValue: self
]

{ #category : #printing }
SAsmConstantExpressionValue >> fullPrintOn: aStream [
	aStream putKeyword: 'const'; space; print: size; nextPutAll: ' := '; space.
	value fullPrintOn: aStream
]

{ #category : #testing }
SAsmConstantExpressionValue >> isConstantExpressionValue [
	^ true
]

{ #category : #accessing }
SAsmConstantExpressionValue >> size [
	^ size
]

{ #category : #accessing }
SAsmConstantExpressionValue >> size: anObject [
	size := anObject
]

{ #category : #accessing }
SAsmConstantExpressionValue >> value [
	^ value
]

{ #category : #accessing }
SAsmConstantExpressionValue >> value: anObject [
	value := anObject
]

{ #category : #writing }
SAsmConstantExpressionValue >> writeToStream: aStreamBuilder [
	aStreamBuilder add: (self copy value: (value copyWithStreamBuilder: aStreamBuilder))
]
