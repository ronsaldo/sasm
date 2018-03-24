Class {
	#name : #SAsmPrintingTextStream,
	#superclass : #SAsmPrintingStream,
	#instVars : [
		'runs'
	],
	#classVars : [
		'IdentifierAttributes',
		'KeywordAttributes'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'as yet unclassified' }
SAsmPrintingTextStream class >> fullPrintString: anObject [
	| stream resultString |
	resultString := ByteString streamContents: [ :out |
		stream := self on: out.
		anObject fullPrintOn: stream.
	].
	stream fillWithDefaultAttributes.
	self assert: resultString size = stream runs size.
	^ Text string: resultString runs: stream runs
]

{ #category : #initialization }
SAsmPrintingTextStream class >> initialize [
	super initialize.
	IdentifierAttributes := {TextColor color: Color orange}.
	KeywordAttributes := {TextColor blue}.
]

{ #category : #'syntax highlighting' }
SAsmPrintingTextStream >> fillWithDefaultAttributes [
	runs add: #() withOccurrences: decoratedStream position - runs size
]

{ #category : #initialization }
SAsmPrintingTextStream >> initialize [
	super initialize.
	runs := RunArray new.
]

{ #category : #'syntax highlighting' }
SAsmPrintingTextStream >> putIdentifier: aString [
	self withAttributes: IdentifierAttributes do: [
		self nextPutAll: aString
	]
	
]

{ #category : #'syntax highlighting' }
SAsmPrintingTextStream >> putKeyword: aString [
	self withAttributes: KeywordAttributes do: [
		self nextPutAll: aString
	]
	
]

{ #category : #accessing }
SAsmPrintingTextStream >> runs [
	^ runs
]

{ #category : #'syntax highlighting' }
SAsmPrintingTextStream >> withAttributes: attributes do: aBlock [
	| startPosition endPosition usedCount |
	self fillWithDefaultAttributes.
	startPosition := decoratedStream position.
	aBlock value.
	endPosition := decoratedStream position.
	
	usedCount := endPosition - startPosition.
	runs add: attributes withOccurrences: usedCount
]
