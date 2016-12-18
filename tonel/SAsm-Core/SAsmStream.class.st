Class {
	#name : #SAsmStream,
	#superclass : #SAsmObject,
	#instVars : [
		'first',
		'last',
		'target'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #adding }
SAsmStream >> add: element [
	^ self addLast: element
]

{ #category : #adding }
SAsmStream >> addFirst: element [
	self assert: element previous isNil.
	self assert: element next isNil.
	element previous: nil.
	element next: first.
	
	first ifNotNil: [ 
		first previous: element
	] ifNil: [ 
		self assert: last isNil.
		last := element
	].
	first := element.
	
	^ element
]

{ #category : #adding }
SAsmStream >> addLast: element [
	self assert: element previous isNil.
	self assert: element next isNil.
	element previous: last.
	element next: nil.
	
	last ifNotNil: [ 
		last next: element
	] ifNil: [ 
		self assert: first isNil.
		first := element
	].
	last := element.
	
	^ element
]

{ #category : #converting }
SAsmStream >> asBinaryObject [
	^ SAsmBinaryObjectWriter writeStream: self
]

{ #category : #building }
SAsmStream >> build: aBlock [
	aBlock value: (SAsmStreamBuilder new stream: self).
	^ self
]

{ #category : #enumerating }
SAsmStream >> collect: aBlock [
	| result |
	result := OrderedCollection new.
	self do: [ :value | result add: (aBlock value: value) ].
	^ result
]

{ #category : #enumerating }
SAsmStream >> do: aBlock [
	| position element result |
	position := first.
	result := nil.
	[ position ] whileNotNil: [ 
		element := position.
		position := position next.
		result := aBlock value: element.
	].
	^ result
]

{ #category : #accessing }
SAsmStream >> first [
	^ first
]

{ #category : #accessing }
SAsmStream >> first: anObject [
	first := anObject
]

{ #category : #printing }
SAsmStream >> fullPrintOn: aStream [
	aStream withExtraIndentationLevel: [
		self do: [ :instruction |
			instruction fullPrintOn: aStream.
			aStream lf
		].
	]

]

{ #category : #'gt-inspector-extension' }
SAsmStream >> gtInspectorAssemblyStreamText: composite [
	<gtInspectorPresentationOrder: 0>  
	^ (composite text)
		title: 'Assembly Stream Code';
		format: #fullPrintText
]

{ #category : #testing }
SAsmStream >> isEmpty [
	^ first isNil
]

{ #category : #testing }
SAsmStream >> isNotEmpty [
	^ first isNotNil
]

{ #category : #accessing }
SAsmStream >> last [
	^ last
]

{ #category : #accessing }
SAsmStream >> last: anObject [
	last := anObject
]

{ #category : #optimizing }
SAsmStream >> optimize [
]

{ #category : #writing }
SAsmStream >> prepareWriteToStream: aStreamBuilder [
	self do: [ :instruction |
		instruction prepareWriteToStream: aStreamBuilder
	]
]

{ #category : #enumerating }
SAsmStream >> select: aBlock [
	| result |
	result := OrderedCollection new.
	self do: [ :value |
		(aBlock value: value) ifTrue: [result add: value ]
	].
	^ result
]

{ #category : #enumerating }
SAsmStream >> select: aBlock thenCollect: mapBlock [
	| result |
	result := OrderedCollection new.
	self do: [ :value |
		(aBlock value: value) ifTrue: [
			result add: (mapBlock value: value)
		]
	].
	^ result

]

{ #category : #enumerating }
SAsmStream >> select: aBlock thenDo: doBlock [
	| result |
	result := nil.
	self do: [ :value |
		(aBlock value: value) ifTrue: [
			result := doBlock value: value
		]
	].
	^ result

]

{ #category : #accessing }
SAsmStream >> target [
	^ target
]

{ #category : #accessing }
SAsmStream >> target: anObject [
	target := anObject
]

{ #category : #writing }
SAsmStream >> writeToStream: aStreamBuilder [
	self do: [ :instruction |
		instruction writeToStream: aStreamBuilder.
	]
]
