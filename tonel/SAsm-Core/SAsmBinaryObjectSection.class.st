Class {
	#name : #SAsmBinaryObjectSection,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'name',
		'data',
		'base',
		'relocations',
		'alignment',
		'size',
		'executable',
		'writeable',
		'loaded',
		'readable',
		'debugging'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #comparing }
SAsmBinaryObjectSection >> = other [
	^ self class = other class
		and: [ name = other name
		and: [ data = other data
		and: [ relocations = other relocations ]]]
]

{ #category : #adding }
SAsmBinaryObjectSection >> addRelocation: aRelocation [
	relocations add: aRelocation
]

{ #category : #accessing }
SAsmBinaryObjectSection >> alignment [
	^ alignment
]

{ #category : #accessing }
SAsmBinaryObjectSection >> alignment: anObject [
	alignment := anObject
]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectSection >> applyRelocations [
	relocations do: [ :reloc |
		reloc applyFullRelocationIn: self
	]
]

{ #category : #accessing }
SAsmBinaryObjectSection >> base [
	^ base
]

{ #category : #accessing }
SAsmBinaryObjectSection >> base: anObject [
	base := anObject
]

{ #category : #accessing }
SAsmBinaryObjectSection >> currentDataSize [
	^ data position
]

{ #category : #accessing }
SAsmBinaryObjectSection >> data [
	^ data
]

{ #category : #accessing }
SAsmBinaryObjectSection >> data: anObject [
	data := anObject
]

{ #category : #accessing }
SAsmBinaryObjectSection >> debugging [
	^ debugging
]

{ #category : #accessing }
SAsmBinaryObjectSection >> debugging: anObject [
	debugging := anObject
]

{ #category : #accessing }
SAsmBinaryObjectSection >> executable [
	^ executable
]

{ #category : #accessing }
SAsmBinaryObjectSection >> executable: anObject [
	executable := anObject
]

{ #category : #accessing }
SAsmBinaryObjectSection >> fileSize [
	^ loaded ifTrue: [ size ] ifFalse: [ 0 ].
]

{ #category : #initialization }
SAsmBinaryObjectSection >> initialize [
	super initialize.
	base := 0.
	relocations := OrderedCollection new.
	alignment := 1.
	executable := false.
	writeable := false.
	readable := false.
	loaded := false.
]

{ #category : #accessing }
SAsmBinaryObjectSection >> loaded [
	^ loaded
]

{ #category : #accessing }
SAsmBinaryObjectSection >> loaded: anObject [
	loaded := anObject
]

{ #category : #accessing }
SAsmBinaryObjectSection >> name [
	^ name
]

{ #category : #accessing }
SAsmBinaryObjectSection >> name: anObject [
	name := anObject
]

{ #category : #'data writing' }
SAsmBinaryObjectSection >> nextPutZeros: count [
	1 to: count do: [ :i | data nextPut: 0 ]
]

{ #category : #accessing }
SAsmBinaryObjectSection >> readable [
	^ readable
]

{ #category : #accessing }
SAsmBinaryObjectSection >> readable: anObject [
	readable := anObject
]

{ #category : #accessing }
SAsmBinaryObjectSection >> relocations [
	^ relocations
]

{ #category : #accessing }
SAsmBinaryObjectSection >> size [
	^ size
]

{ #category : #accessing }
SAsmBinaryObjectSection >> size: aSize [
	size := aSize
]

{ #category : #writing }
SAsmBinaryObjectSection >> writeOn: aStream [
	loaded ifTrue: [ aStream nextPutAll: data ]
	
]

{ #category : #accessing }
SAsmBinaryObjectSection >> writeable [
	^ writeable
]

{ #category : #accessing }
SAsmBinaryObjectSection >> writeable: anObject [
	writeable := anObject
]
