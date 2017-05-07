Class {
	#name : #SAsmElf32SymbolTable,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'sectionHeader',
		'entries',
		'localEntries'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #adding }
SAsmElf32SymbolTable >> addRelocationSectionSymbol: section [
	| elfSymbol binding type |
	binding := 0.
	type := 3.
	elfSymbol := self symbolEntryClass new
		name: 0;
		value: 0;
		info: binding << 4 | (type bitAnd: 16rf);
		sectionHeaderIndex: section index;
		index: localEntries size.
	localEntries add: elfSymbol.
	^ elfSymbol
]

{ #category : #adding }
SAsmElf32SymbolTable >> addSymbol: symbol stringTable: stringTable sectionDictionary: sectionIndexDictionary [
	| elfSymbol binding type |
	binding := symbol isExternal
		ifTrue: [ 1 ]
		ifFalse: [ symbol isWeak ifTrue: [ 2 ] ifFalse: [ 0 ] ].
	type := 0.
	symbol type == #function ifTrue: [ 
		type := 2
	].

	elfSymbol := self symbolEntryClass new
		name: (symbol isPrivate ifTrue: [ 0 ] ifFalse: [ stringTable addString: symbol name ]);
		value: (symbol value ifNil: [0]);
		size: symbol size;
		info: binding << 4 | (type bitAnd: 16rf);
		sectionHeaderIndex: (symbol section ifNil: [0] ifNotNil: [sectionIndexDictionary at: symbol section]).
	binding = 0 ifTrue: [
		elfSymbol index: localEntries size.
		localEntries add: elfSymbol
	] ifFalse: [
		elfSymbol index: localEntries size + entries size.
		entries add: elfSymbol
	].

	^ elfSymbol
]

{ #category : #initialization }
SAsmElf32SymbolTable >> initialize [
	super initialize.
	localEntries := OrderedCollection new.
	localEntries add: self symbolEntryClass new.
	entries := OrderedCollection new.
]

{ #category : #writing }
SAsmElf32SymbolTable >> prepareForWritingToFile [
	super prepareForWritingToFile.
	sectionHeader info: localEntries size.
]

{ #category : #accessing }
SAsmElf32SymbolTable >> sectionHeader [
	^ sectionHeader
]

{ #category : #accessing }
SAsmElf32SymbolTable >> sectionHeader: anObject [
	sectionHeader := anObject
]

{ #category : #accessing }
SAsmElf32SymbolTable >> size [
	^ self symbolEntryClass entrySize * (localEntries size + entries size)
]

{ #category : #factory }
SAsmElf32SymbolTable >> symbolEntryClass [
	^ SAsmElf32SymbolTableEntry
]

{ #category : #writing }
SAsmElf32SymbolTable >> writeOn: aStream [
	localEntries do: [ :entry | entry writeOn: aStream ].
	entries do: [ :entry | entry writeOn: aStream ]
]
