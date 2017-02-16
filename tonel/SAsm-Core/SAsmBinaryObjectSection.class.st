Class {
	#name : #SAsmBinaryObjectSection,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'name',
		'data',
		'base',
		'relocations',
		'alignment'
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
SAsmBinaryObjectSection >> data [
	^ data
]

{ #category : #accessing }
SAsmBinaryObjectSection >> data: anObject [
	data := anObject
]

{ #category : #initialization }
SAsmBinaryObjectSection >> initialize [
	super initialize.
	base := 0.
	relocations := OrderedCollection new.
	alignment := 1.
]

{ #category : #accessing }
SAsmBinaryObjectSection >> name [
	^ name
]

{ #category : #accessing }
SAsmBinaryObjectSection >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SAsmBinaryObjectSection >> relocations [
	^ relocations
]

{ #category : #accessing }
SAsmBinaryObjectSection >> size [
	^ data size
]

{ #category : #writing }
SAsmBinaryObjectSection >> writeOn: aStream [
	aStream nextPutAll: data
]
