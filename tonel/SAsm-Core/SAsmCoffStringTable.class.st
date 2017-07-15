Class {
	#name : #SAsmCoffStringTable,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'content',
		'stringDictionary'
	],
	#category : #'SAsm-Core-Coff'
}

{ #category : #adding }
SAsmCoffStringTable >> addString: aString [
	| result |
	^ stringDictionary at: aString ifAbsentPut: [ 
		result := content position.
		aString do: [ :char | content nextPut: char asInteger ].
		content nextPut: 0.
		result + 4
	]
]

{ #category : #adding }
SAsmCoffStringTable >> contents [
	^ content contents
]

{ #category : #adding }
SAsmCoffStringTable >> initialize [
	super initialize.
	content := WriteStream on: (ByteArray new: 100).
	stringDictionary := Dictionary new.
	self addString: ''.
]

{ #category : #adding }
SAsmCoffStringTable >> size [
	^ content size + 4
]

{ #category : #accessing }
SAsmCoffStringTable >> stringDictionary [
	^ stringDictionary
]

{ #category : #accessing }
SAsmCoffStringTable >> stringDictionary: anObject [
	stringDictionary := anObject
]

{ #category : #adding }
SAsmCoffStringTable >> writeOn: aStream [
	| contents |
	contents := self contents.
	aStream
		nextPutInt32: contents size + 4;
		nextPutAll: contents
]
