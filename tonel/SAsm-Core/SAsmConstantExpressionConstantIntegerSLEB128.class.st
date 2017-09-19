Class {
	#name : #SAsmConstantExpressionConstantIntegerSLEB128,
	#superclass : #SAsmConstantExpressionConstant,
	#instVars : [
		'size'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #printing }
SAsmConstantExpressionConstantIntegerSLEB128 >> fullPrintOn: aStream [
	aStream putKeyword: #sleb128; space; putNumber: value
]

{ #category : #writing }
SAsmConstantExpressionConstantIntegerSLEB128 >> size [
	^ size
]

{ #category : #writing }
SAsmConstantExpressionConstantIntegerSLEB128 >> value: aValue [
	| currentValue more byte |
	more := true.
	currentValue := aValue.
	size := 0.
	[ more ] whileTrue: [ 
		byte := currentValue & 127.
		currentValue := currentValue >> 7.
		
		((currentValue = 0 and: [ byte & 64 = 0]) or:
		[ (currentValue = -1 and: [ byte & 64 ~= 0]) ]) ifTrue: [ 
			more := false.
		] ifFalse: [
			byte := byte | 128
		].
	
		size := size + 1
	].
	value := aValue
]

{ #category : #writing }
SAsmConstantExpressionConstantIntegerSLEB128 >> writeWithSize: targetSize on: writer [
	| currentValue more byte |
	more := true.
	currentValue := value.
	[ more ] whileTrue: [ 
		byte := currentValue & 127.
		currentValue := currentValue >> 7.
		
		((currentValue = 0 and: [ byte & 64 = 0]) or:
		[ (currentValue = -1 and: [ byte & 64 ~= 0]) ]) ifTrue: [ 
			more := false.
		] ifFalse: [
			byte := byte | 128
		].
	
		writer nextPutC8: byte
	]
]
