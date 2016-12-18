Class {
	#name : #SAsmPrintingTextStream,
	#superclass : #SAsmPrintingStream,
	#classVars : [
		'IdentifierColor',
		'KeywordColor'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'as yet unclassified' }
SAsmPrintingTextStream class >> fullPrintString: anObject [
	^ Text streamContents: [ :out | anObject fullPrintOn: (self on: out) ]
]

{ #category : #'as yet unclassified' }
SAsmPrintingTextStream class >> initialize [
	super initialize.
	IdentifierColor := TextColor color: Color orange.
	KeywordColor := TextColor blue.
]

{ #category : #'syntax highlighting' }
SAsmPrintingTextStream >> putIdentifier: aString [
	decoratedStream withAttribute: IdentifierColor do: [
		self nextPutAll: aString
	]
	
]

{ #category : #'syntax highlighting' }
SAsmPrintingTextStream >> putKeyword: aString [
	decoratedStream withAttribute: KeywordColor do: [
		self nextPutAll: aString
	]
	
]
