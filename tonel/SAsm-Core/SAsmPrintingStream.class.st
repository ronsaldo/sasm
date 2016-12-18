Class {
	#name : #SAsmPrintingStream,
	#superclass : #DecoratorStream,
	#instVars : [
		'tabCount',
		'startingLine'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'as yet unclassified' }
SAsmPrintingStream class >> fullPrintString: anObject [
	^ ByteString streamContents: [ :out | anObject fullPrintOn: (self on: out) ]
]

{ #category : #'code generation' }
SAsmPrintingStream >> emitTabs [
	1 to: tabCount do: [ :i | decoratedStream tab ]
]

{ #category : #initialization }
SAsmPrintingStream >> initialize [
	super initialize.
	tabCount := 0.
	startingLine := true.
]

{ #category : #writing }
SAsmPrintingStream >> lf [
	decoratedStream lf.
	startingLine := true.
]

{ #category : #accessing }
SAsmPrintingStream >> nextPut: aValue [
	startingLine ifTrue: [ 
		startingLine := false.
		self emitTabs.
	].
	^ decoratedStream nextPut: aValue
]

{ #category : #'syntax highlighting' }
SAsmPrintingStream >> putIdentifier: aString [
	self nextPutAll: aString
]

{ #category : #'syntax highlighting' }
SAsmPrintingStream >> putKeyword: aString [
	self nextPutAll: aString
]

{ #category : #'syntax highlighting' }
SAsmPrintingStream >> putNumber: aNumber [
	self print: aNumber
]

{ #category : #'syntax highlighting' }
SAsmPrintingStream >> putSectionProperty: name boolean: value [
	value ifFalse: [ ^ self ].
	self putKeyword: name; space.
]

{ #category : #writing }
SAsmPrintingStream >> space [
	decoratedStream space
]

{ #category : #'code generation' }
SAsmPrintingStream >> withExtraIndentationLevel: aBlock [
	tabCount := tabCount + 1.
	aBlock ensure: [ tabCount := tabCount - 1 ].
]

{ #category : #'code generation' }
SAsmPrintingStream >> withLessIndentationLevel: aBlock [
	tabCount := tabCount - 1.
	aBlock ensure: [ tabCount := tabCount + 1 ].
]
