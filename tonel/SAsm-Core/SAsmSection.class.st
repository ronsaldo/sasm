Class {
	#name : #SAsmSection,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'name',
		'loaded',
		'executable',
		'readable',
		'writeable',
		'debugging'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #visiting }
SAsmSection >> accept: aVisitor [
	^ aVisitor visitSection: self
]

{ #category : #accessing }
SAsmSection >> debugging [
	^ debugging
]

{ #category : #accessing }
SAsmSection >> debugging: anObject [
	debugging := anObject
]

{ #category : #accessing }
SAsmSection >> executable [
	^ executable
]

{ #category : #accessing }
SAsmSection >> executable: anObject [
	executable := anObject
]

{ #category : #printing }
SAsmSection >> fullPrintOn: aStream [
	aStream withLessIndentationLevel: [
		aStream putKeyword: 'section'; space; putIdentifier: name; space; nextPutAll: '#('; space;
			putSectionProperty: #loaded boolean: loaded;
			putSectionProperty: #readable boolean: readable;
			putSectionProperty: #writeable boolean: writeable;
			putSectionProperty: #executable boolean: executable;
			nextPut: $).
	]
]

{ #category : #testing }
SAsmSection >> hasFixedSize [
	^ true
]

{ #category : #initialization }
SAsmSection >> initialize [
	super initialize.
	loaded := false.
	executable := false.
	readable := true.
	writeable := false.
]

{ #category : #testing }
SAsmSection >> isSection [
	^ true
]

{ #category : #accessing }
SAsmSection >> loaded [
	^ loaded
]

{ #category : #accessing }
SAsmSection >> loaded: anObject [
	loaded := anObject
]

{ #category : #accessing }
SAsmSection >> name [
	^ name
]

{ #category : #accessing }
SAsmSection >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SAsmSection >> readable [
	^ readable
]

{ #category : #accessing }
SAsmSection >> readable: anObject [
	readable := anObject
]

{ #category : #accessing }
SAsmSection >> size [
	^ 0
]

{ #category : #accessing }
SAsmSection >> writeable [
	^ writeable
]

{ #category : #accessing }
SAsmSection >> writeable: anObject [
	writeable := anObject
]
