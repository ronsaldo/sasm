Class {
	#name : #SAsmConstantExpressionConstantInteger,
	#superclass : #SAsmConstantExpressionConstant,
	#instVars : [
		'size'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #testing }
SAsmConstantExpressionConstantInteger >> isConstantExpressionConstantInteger [
	^ true
]

{ #category : #accessing }
SAsmConstantExpressionConstantInteger >> size [
	^ size
]

{ #category : #accessing }
SAsmConstantExpressionConstantInteger >> size: anObject [
	size := anObject
]

{ #category : #writing }
SAsmConstantExpressionConstantInteger >> writeWithSize: targetSize on: writer [
	| temp |
	self assert: (size isNil or: [targetSize = size]).
	temp := value.
	1 to: targetSize do: [ :i |
		writer nextPut: temp & 16rff.
		temp := temp >> 8
	].
]
