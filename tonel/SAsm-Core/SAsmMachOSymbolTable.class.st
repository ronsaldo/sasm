Class {
	#name : #SAsmMachOSymbolTable,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'localSymbols',
		'externalSymbols',
		'undefinedSymbols',
		'entryClass',
		'stringTable'
	],
	#pools : [
		'SAsmMachConstants'
	],
	#category : #'SAsm-Core-MachO'
}

{ #category : #'instance creation' }
SAsmMachOSymbolTable class >> for: entryClass [
	^ self new entryClass: entryClass
]

{ #category : #adding }
SAsmMachOSymbolTable >> addSymbol: symbol sectionDictionary: sectionIndexDictionary [
	| machoSymbol machoSection |
	machoSymbol := entryClass new.
	machoSymbol
		n_strx: (symbol isPrivate ifTrue: [ 0 ] ifFalse: [ stringTable addString: symbol name ]);
		n_value: (symbol value ifNil: [0]).
		
	symbol section ifNil: [ 
		machoSymbol
			n_type: N_UNDF;
			n_sect: NO_SECT.
		undefinedSymbols add: machoSymbol
	] ifNotNil: [ 
		machoSection := sectionIndexDictionary at: symbol section.
		machoSymbol
			n_value: machoSymbol n_value + machoSection addr;
			n_type: N_SECT;
			n_sect: machoSection index.

		(symbol isExternal or: [ symbol isPublic ]) ifTrue: [
			externalSymbols add: machoSymbol
		] ifFalse: [
			localSymbols add: machoSymbol
		].
	].

	^ machoSymbol
]

{ #category : #accessing }
SAsmMachOSymbolTable >> entryClass [
	^ entryClass
]

{ #category : #accessing }
SAsmMachOSymbolTable >> entryClass: anObject [
	entryClass := anObject
]

{ #category : #accessing }
SAsmMachOSymbolTable >> externalSymbols [
	^ externalSymbols
]

{ #category : #initialization }
SAsmMachOSymbolTable >> initialize [
	super initialize.
	localSymbols := OrderedCollection new.
	externalSymbols := OrderedCollection new.
	undefinedSymbols := OrderedCollection new.
	
]

{ #category : #accessing }
SAsmMachOSymbolTable >> localSymbols [
	^ localSymbols
]

{ #category : #accessing }
SAsmMachOSymbolTable >> size [
	^ entryClass entrySize * self symbolCount
]

{ #category : #accessing }
SAsmMachOSymbolTable >> stringTable [
	^ stringTable
]

{ #category : #accessing }
SAsmMachOSymbolTable >> stringTable: anObject [
	stringTable := anObject
]

{ #category : #accessing }
SAsmMachOSymbolTable >> symbolCount [
	^ localSymbols size + externalSymbols size + undefinedSymbols size
]

{ #category : #accessing }
SAsmMachOSymbolTable >> undefinedSymbols [
	^ undefinedSymbols
]

{ #category : #accessing }
SAsmMachOSymbolTable >> writeOn: aStream [
	localSymbols do: [ :sym | sym writeOn: aStream ].
	externalSymbols do: [ :sym | sym writeOn: aStream ].
	undefinedSymbols do: [ :sym | sym writeOn: aStream ].
]
