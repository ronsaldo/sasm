Class {
	#name : #SAsmBinaryFileCStringTable,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'content',
		'stringDictionary'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #adding }
SAsmBinaryFileCStringTable >> addString: aString [
	| result |
	^ stringDictionary at: aString ifAbsentPut: [ 
		result := content position.
		aString do: [ :char | content nextPut: char asInteger ].
		content nextPut: 0.
		result
	]
]

{ #category : #accessing }
SAsmBinaryFileCStringTable >> contents [
	^ content contents
]

{ #category : #initialization }
SAsmBinaryFileCStringTable >> initialize [
	super initialize.
	content := WriteStream on: (ByteArray new: 100).
	stringDictionary := Dictionary new.
	self addString: ''.
]

{ #category : #accessing }
SAsmBinaryFileCStringTable >> size [
	^ content size
]

{ #category : #'as yet unclassified' }
SAsmBinaryFileCStringTable >> writeOn: aStream [
	aStream nextPutAll: self contents
]
