Class {
	#name : #SAsmConstantExpressionString,
	#superclass : #SAsmConstantExpression,
	#instVars : [
		'data',
		'hasExtraNullCharacter'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #accessing }
SAsmConstantExpressionString >> data [
	^ data
]

{ #category : #accessing }
SAsmConstantExpressionString >> data: anObject [
	data := anObject
]

{ #category : #'public access' }
SAsmConstantExpressionString >> evaluate [
	^ self
]

{ #category : #accessing }
SAsmConstantExpressionString >> extraSize [
	^ hasExtraNullCharacter ifTrue: [ 1 ] ifFalse: [0]
]

{ #category : #writing }
SAsmConstantExpressionString >> fullPrintOn: aStream [
	aStream putKeyword: (hasExtraNullCharacter ifTrue: ['cstring'] ifFalse: ['string']); space; print: data
]

{ #category : #accessing }
SAsmConstantExpressionString >> hasExtraNullCharacter [
	^ hasExtraNullCharacter
]

{ #category : #accessing }
SAsmConstantExpressionString >> hasExtraNullCharacter: anObject [
	hasExtraNullCharacter := anObject
]

{ #category : #initialization }
SAsmConstantExpressionString >> initialize [
	super initialize.
	hasExtraNullCharacter := false.
]

{ #category : #accessing }
SAsmConstantExpressionString >> size [
	^ data size + self extraSize
]

{ #category : #writing }
SAsmConstantExpressionString >> writeWithSize: valueSize on: writer [
	data do: [ :char | writer nextPutC8: char asInteger ].
	hasExtraNullCharacter ifTrue: [ writer nextPutC8: 0 ]
]
