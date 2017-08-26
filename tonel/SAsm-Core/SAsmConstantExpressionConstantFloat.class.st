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

{ #category : #writing }
SAsmConstantExpressionConstantFloat >> writeWithSize: targetSize on: writer [
	| temp |
	self assert: (size isNil or: [targetSize = size]).
	size = 4 ifTrue: [
		temp := value asIEEE32BitWord
	] ifFalse: [ 
		self assert: size = 8.
		temp := ((value basicAt: 1) << 32) | (value basicAt: 2)
	].
	1 to: targetSize do: [ :i |
		writer nextPut: temp & 16rff.
		temp := temp >> 8
	].
]
