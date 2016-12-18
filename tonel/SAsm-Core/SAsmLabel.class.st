Class {
	#name : #SAsmLabel,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'symbol'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #visiting }
SAsmLabel >> accept: aVisitor [
	^ aVisitor visitLabel: self
]

{ #category : #printing }
SAsmLabel >> fullPrintOn: aStream [
	aStream withLessIndentationLevel: [
		symbol fullPrintOn: aStream.
		aStream nextPut: $:
	]
]

{ #category : #testing }
SAsmLabel >> isLabel [
	^ true
]

{ #category : #writing }
SAsmLabel >> prepareWriteToStream: aStreamBuilder [
	aStreamBuilder addSymbolCopy: symbol
]

{ #category : #printing }
SAsmLabel >> printOn: aStream [
	aStream print: symbol
]

{ #category : #accessing }
SAsmLabel >> size [
	^ 0
]

{ #category : #accessing }
SAsmLabel >> symbol [
	^ symbol
]

{ #category : #accessing }
SAsmLabel >> symbol: anObject [
	symbol := anObject
]
