Class {
	#name : #SAsmElfRelocationTable,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'entries'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #initialization }
SAsmElfRelocationTable >> initialize [
	super initialize.
	entries := OrderedCollection new.
]

{ #category : #initialization }
SAsmElfRelocationTable >> newEntry [
	^ entries add: self relocationEntryClass new
]

{ #category : #factory }
SAsmElfRelocationTable >> relocationEntryClass [
	self subclassResponsibility
]

{ #category : #accessing }
SAsmElfRelocationTable >> size [
	^ self relocationEntryClass entrySize * entries size
]

{ #category : #writing }
SAsmElfRelocationTable >> writeOn: aStream [
	entries do: [ :entry | entry writeOn: aStream ]
]
