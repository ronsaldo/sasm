Class {
	#name : #SAsmConstantZeros,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'size'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #visiting }
SAsmConstantZeros >> accept: aVisitor [
	^ aVisitor visitConstantZeros: self
]

{ #category : #printing }
SAsmConstantZeros >> fullPrintOn: aStream [
	aStream putKeyword: 'zeros '; print: size
]

{ #category : #testing }
SAsmConstantZeros >> hasFixedSize [
	^ true
]

{ #category : #testing }
SAsmConstantZeros >> isConstantZeros [
	^ true
]

{ #category : #accessing }
SAsmConstantZeros >> size [
	^ size
]

{ #category : #accessing }
SAsmConstantZeros >> size: anObject [
	size := anObject
]
