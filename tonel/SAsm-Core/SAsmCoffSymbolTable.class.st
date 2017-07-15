Class {
	#name : #SAsmCoffSymbolTable,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'entries'
	],
	#pools : [
		'SAsmCoffConstants'
	],
	#category : #'SAsm-Core-Coff'
}

{ #category : #adding }
SAsmCoffSymbolTable >> addRelocationSectionSymbol: sectionHeader [
	| coffSymbol |
	coffSymbol := SAsmCoffSymbolTableEntry new.
	coffSymbol
		sectionNumber: sectionHeader index;
		storageClass: IMAGE_SYM_CLASS_STATIC;
		index: entries size.
	entries add: coffSymbol.
	^ coffSymbol	
]

{ #category : #adding }
SAsmCoffSymbolTable >> addSymbol: symbol stringTable: stringTable sectionDictionary: sectionIndexDictionary [
	| coffSymbol storageClass type |
	
	symbol isWeak ifTrue: [ 
		^ self addWeakSymbol: symbol stringTable: stringTable sectionDictionary: sectionIndexDictionary
	].
	storageClass := (symbol isExternal or: [ symbol isPublic or: [symbol isWeak]])
		ifTrue: [ IMAGE_SYM_CLASS_EXTERNAL ]
		ifFalse: [ IMAGE_SYM_CLASS_STATIC ].
		
	type := 0.
	symbol type == #function ifTrue: [ 
		type := 16r20
	].

	coffSymbol := SAsmCoffSymbolTableEntry new.
	symbol isPrivate ifFalse: [ 
		self setSymbol: coffSymbol name: symbol name withStringTable: stringTable
	].
	
	coffSymbol
		value: (symbol value ifNil: [0]);
		sectionNumber: (symbol section ifNil: [0] ifNotNil: [sectionIndexDictionary at: symbol section]);
		storageClass: storageClass;
		type: type;
		index: entries size.
	entries add: coffSymbol.
	
	^ coffSymbol
]

{ #category : #adding }
SAsmCoffSymbolTable >> addWeakSymbol: symbol stringTable: stringTable sectionDictionary: sectionIndexDictionary [
	self halt
]

{ #category : #initialization }
SAsmCoffSymbolTable >> initialize [
	super initialize.
	entries := OrderedCollection new.
	
]

{ #category : #accessing }
SAsmCoffSymbolTable >> numberOfSymbols [
	^ entries size
]

{ #category : #adding }
SAsmCoffSymbolTable >> setSymbol: symbol name: name withStringTable: stringTable [
	| nameIndex dest |
	dest := symbol nameEncoding.
	name size <= 8 ifTrue: [
		1 to: name size do: [ :i |
			dest at: i put: (name at: i) asInteger
		]
	] ifFalse: [ 
		nameIndex := stringTable addString: name.
		dest
			at: 1 put: 0;
			at: 2 put: 0;
			at: 3 put: 0;
			at: 4 put: 0;
			at: 5 put: nameIndex & 16rff;
			at: 6 put: (nameIndex >> 8) & 16rff;
			at: 7 put: (nameIndex >> 16) & 16rff;
			at: 8 put: (nameIndex >> 24) & 16rff
	]
]

{ #category : #initialization }
SAsmCoffSymbolTable >> size [
	^ SAsmCoffSymbolTableEntry entrySize * entries size
]

{ #category : #writing }
SAsmCoffSymbolTable >> writeOn: aStream [
	entries do: [ :entry | entry writeOn: aStream ]
]
