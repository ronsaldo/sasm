Class {
	#name : #SAsmMachORelocationTable,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'entries'
	],
	#pools : [
		'SAsmMachConstants'
	],
	#category : #'SAsm-Core-MachO'
}

{ #category : #initialization }
SAsmMachORelocationTable >> entryCount [
	^ entries size
]

{ #category : #'as yet unclassified' }
SAsmMachORelocationTable >> initialize [
	super initialize.
	entries := OrderedCollection new.
]

{ #category : #'instance creation' }
SAsmMachORelocationTable >> newEntry [
	| result |
	result := SAsmMachORelocationInfo new.
	entries add: result.
	^ result
]

{ #category : #'as yet unclassified' }
SAsmMachORelocationTable >> size [
	^ entries size * SAsmMachORelocationInfo entrySize
]

{ #category : #writing }
SAsmMachORelocationTable >> writeOn: aStream [
	entries do: [ :entry | entry writeOn: aStream ]
]
