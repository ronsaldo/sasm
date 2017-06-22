Class {
	#name : #SAsmDWDebugInfoEntryAttribute,
	#superclass : #SAsmDWObject,
	#instVars : [
		'next',
		'name',
		'value'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #'instance creation' }
SAsmDWDebugInfoEntryAttribute class >> name: aName value: aValue [
	^ self new name: aName; value: aValue; yourself
]

{ #category : #'as yet unclassified' }
SAsmDWDebugInfoEntryAttribute >> abbreviationEquals: other [
	^ name = other name
]

{ #category : #'as yet unclassified' }
SAsmDWDebugInfoEntryAttribute >> abbreviationHash [
	^ name hash
]

{ #category : #accessing }
SAsmDWDebugInfoEntryAttribute >> name [
	^ name
]

{ #category : #accessing }
SAsmDWDebugInfoEntryAttribute >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SAsmDWDebugInfoEntryAttribute >> next [
	^ next
]

{ #category : #accessing }
SAsmDWDebugInfoEntryAttribute >> next: anObject [
	next := anObject
]

{ #category : #'as yet unclassified' }
SAsmDWDebugInfoEntryAttribute >> prepareForWritingWith: writer [
]

{ #category : #printing }
SAsmDWDebugInfoEntryAttribute >> printOn: aStream [
	aStream print: name; space; print: value
]

{ #category : #accessing }
SAsmDWDebugInfoEntryAttribute >> value [
	^ value
]

{ #category : #accessing }
SAsmDWDebugInfoEntryAttribute >> value: anObject [
	value := anObject
]

{ #category : #writing }
SAsmDWDebugInfoEntryAttribute >> writeAbbreviationFormWith: writer to: streamBuilder [
	self subclassResponsibility
]

{ #category : #writing }
SAsmDWDebugInfoEntryAttribute >> writeAbbreviationWith: writer to: streamBuilder [
	streamBuilder uleb128: name.
	self writeAbbreviationFormWith: writer to: streamBuilder
]

{ #category : #writing }
SAsmDWDebugInfoEntryAttribute >> writeAttributeWith: writer to: streamBuilder [
	self subclassResponsibility
]
