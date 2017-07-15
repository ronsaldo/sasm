Class {
	#name : #SAsmCoffRelocationTable,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'entries'
	],
	#category : #'SAsm-Core-Coff'
}

{ #category : #initialization }
SAsmCoffRelocationTable >> initialize [
	entries := OrderedCollection new.
]

{ #category : #'instance creation' }
SAsmCoffRelocationTable >> newEntry [
	| entry |
	entry := SAsmCoffRelocationEntry new.
	entries add: entry.
	
	"In the overflow case, we have to store the number of relocations in the first entry."
	entries size = 16r10000 ifTrue: [
		entries addFirst: SAsmCoffRelocationEntry new.
	].

	^ entry
]

{ #category : #accessing }
SAsmCoffRelocationTable >> numberOfRelocations [
	^ entries size
]

{ #category : #'instance creation' }
SAsmCoffRelocationTable >> prepareForWriting [
	entries size >= 16r1000 ifTrue: [ 
		entries first virtualAddress: entries size.
	]
]

{ #category : #accessing }
SAsmCoffRelocationTable >> size [
	^ entries size * SAsmCoffRelocationEntry entrySize
]

{ #category : #initialization }
SAsmCoffRelocationTable >> writeOn: aStream [
	entries do: [ :entry | entry writeOn: aStream ]
]
