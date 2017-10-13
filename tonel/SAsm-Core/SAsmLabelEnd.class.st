Class {
	#name : #SAsmLabelEnd,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'symbol'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #visiting }
SAsmLabelEnd >> accept: aVisitor [
	^ aVisitor visitLabelEnd: self
]

{ #category : #printing }
SAsmLabelEnd >> fullPrintOn: aStream [
	aStream withLessIndentationLevel: [
		aStream putKeyword: #endof; space. symbol fullPrintOn: aStream.
	]
]

{ #category : #testing }
SAsmLabelEnd >> hasFixedSize [
	^ true
]

{ #category : #visiting }
SAsmLabelEnd >> prepareWriteToStream: aStreamBuilder [
	aStreamBuilder addSymbolCopy: symbol
]

{ #category : #visiting }
SAsmLabelEnd >> size [
	^ 0
]

{ #category : #accessing }
SAsmLabelEnd >> symbol [
	^ symbol
]

{ #category : #accessing }
SAsmLabelEnd >> symbol: anObject [
	symbol := anObject
]

{ #category : #visiting }
SAsmLabelEnd >> writeToStream: aStreamBuilder [
	aStreamBuilder add: (self copy symbol: (aStreamBuilder findSymbolForObject: symbol))
]
