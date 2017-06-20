Class {
	#name : #SAsmConstantExpressionConstantIntegerULEB128,
	#superclass : #SAsmConstantExpressionConstant,
	#instVars : [
		'size'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #printing }
SAsmConstantExpressionConstantIntegerULEB128 >> fullPrintOn: aStream [
	aStream putKeyword: #uleb128; space; putNumber: value
]

{ #category : #accessing }
SAsmConstantExpressionConstantIntegerULEB128 >> size [
	^ size
]

{ #category : #accessing }
SAsmConstantExpressionConstantIntegerULEB128 >> value: aValue [
	| currentValue |
	size := 0.
	currentValue := aValue value & 16rFFFFFFFFFFFFFFFF.
	[
		size := size + 1.
		currentValue := currentValue >> 7.
	] doWhileTrue: [ currentValue ~= 0 ].

	value := aValue
]

{ #category : #accessing }
SAsmConstantExpressionConstantIntegerULEB128 >> writeWithSize: targetSize on: writer [
	| currentValue |
	self assert: size = targetSize.
	currentValue := value value & 16rFFFFFFFFFFFFFFFF.
	[
		writer nextPutC8: currentValue & 127.
		currentValue := currentValue >> 7.
	] doWhileTrue: [ currentValue ~= 0 ].
]
