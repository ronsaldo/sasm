Class {
	#name : #SAsmElfStringTable,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'content',
		'stringDictionary'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #adding }
SAsmElfStringTable >> addString: aString [
	| result |
	^ stringDictionary at: aString ifAbsentPut: [ 
		result := content position.
		aString do: [ :char | content nextPut: char asInteger ].
		content nextPut: 0.
		result
	]
]

{ #category : #accessing }
SAsmElfStringTable >> contents [
	^ content contents
]

{ #category : #initialization }
SAsmElfStringTable >> initialize [
	super initialize.
	content := WriteStream on: (ByteArray new: 100).
	stringDictionary := Dictionary new.
	self addString: ''.
]

{ #category : #accessing }
SAsmElfStringTable >> size [
	^ content size
]

{ #category : #'as yet unclassified' }
SAsmElfStringTable >> writeOn: aStream [
	aStream nextPutAll: self contents
]
