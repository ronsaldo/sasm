Class {
	#name : #SAsmBinaryObjectWriterShortLongBranch,
	#superclass : #Object,
	#instVars : [
		'index',
		'instruction',
		'destination',
		'span',
		'dependencies',
		'parents',
		'promotedToLong'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #adding }
SAsmBinaryObjectWriterShortLongBranch >> addDependency: dependency [
	dependencies add: dependency.
	dependency parents add: self
]

{ #category : #accessing }
SAsmBinaryObjectWriterShortLongBranch >> dependencies [
	^ dependencies
]

{ #category : #accessing }
SAsmBinaryObjectWriterShortLongBranch >> destination [
	^ destination
]

{ #category : #accessing }
SAsmBinaryObjectWriterShortLongBranch >> destination: anObject [
	destination := anObject
]

{ #category : #testing }
SAsmBinaryObjectWriterShortLongBranch >> hasShortSpan [
	^ instruction isShortBranchSpan: span
]

{ #category : #accessing }
SAsmBinaryObjectWriterShortLongBranch >> index [
	^ index
]

{ #category : #accessing }
SAsmBinaryObjectWriterShortLongBranch >> index: anObject [
	index := anObject
]

{ #category : #initialization }
SAsmBinaryObjectWriterShortLongBranch >> initialize [
	super initialize.
	dependencies := OrderedCollection new.
	parents := OrderedCollection new.
	promotedToLong := false
]

{ #category : #accessing }
SAsmBinaryObjectWriterShortLongBranch >> instruction [
	^ instruction
]

{ #category : #accessing }
SAsmBinaryObjectWriterShortLongBranch >> instruction: anObject [
	instruction := anObject
]

{ #category : #accessing }
SAsmBinaryObjectWriterShortLongBranch >> parents [
	^ parents
]

{ #category : #printing }
SAsmBinaryObjectWriterShortLongBranch >> printOn: aStream [
	aStream nextPutAll: 'branch '; print: index.
	aStream nextPutAll: ' span '; print: span.
	aStream nextPutAll: ' dependencies'.
	dependencies do: [ :dep | aStream space; print: dep index ].
	aStream nextPutAll: ' parents'.
	parents do: [ :dep | aStream space; print: dep index ]
]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectWriterShortLongBranch >> promoteToLongBranch [
	| sizeIncrement |
	self assert: promotedToLong not.
	promotedToLong := true.
	instruction selectLongAlternative.
	sizeIncrement := instruction longAlternativeSize - instruction shortAlternativeSize.
	parents do: [ :parent |
		parent index < index ifTrue: [
			"Parent - Me. More forward"
			parent span: parent span + sizeIncrement
		] ifFalse: [
			"Me - Parent. Move less"
			self assert: index < parent index.
			parent span: parent span - sizeIncrement
		]
	].
	
]

{ #category : #accessing }
SAsmBinaryObjectWriterShortLongBranch >> promotedToLong [
	^ promotedToLong
]

{ #category : #accessing }
SAsmBinaryObjectWriterShortLongBranch >> span [
	^ span
]

{ #category : #accessing }
SAsmBinaryObjectWriterShortLongBranch >> span: anObject [
	span := anObject
]
