Class {
	#name : #SAsmElfRelocationTable,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'sectionHeader',
		'entries'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #accessing }
SAsmElfRelocationTable >> entries [
	^ entries
]

{ #category : #initialization }
SAsmElfRelocationTable >> initialize [
	super initialize.
	entries := OrderedCollection new.
]

{ #category : #initialization }
SAsmElfRelocationTable >> newEntry [
	^ entries add: self relocationEntryClass new
]

{ #category : #reading }
SAsmElfRelocationTable >> readEntryFrom: in [
	| startPosition entry |
	startPosition := in position.
	entry := self relocationEntryClass new
		readFrom: in;
		yourself.
	in position: startPosition + sectionHeader entrySize.
	^ entry
]

{ #category : #reading }
SAsmElfRelocationTable >> readFrom: in [
	| entryCount |
	entryCount := sectionHeader contentSize // sectionHeader entrySize.
	in position: sectionHeader offset.
	
	1 to: entryCount do: [ :i |
		entries add: (self readEntryFrom: in)
	]
]

{ #category : #factory }
SAsmElfRelocationTable >> relocationEntryClass [
	self subclassResponsibility
]

{ #category : #accessing }
SAsmElfRelocationTable >> sectionHeader [
	^ sectionHeader
]

{ #category : #accessing }
SAsmElfRelocationTable >> sectionHeader: anObject [
	sectionHeader := anObject
]

{ #category : #accessing }
SAsmElfRelocationTable >> size [
	^ self relocationEntryClass entrySize * entries size
]

{ #category : #writing }
SAsmElfRelocationTable >> writeOn: aStream [
	entries do: [ :entry | entry writeOn: aStream ]
]
