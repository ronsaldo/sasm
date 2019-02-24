Class {
	#name : #SAsmElfLoader,
	#superclass : #Object,
	#instVars : [
		'header',
		'sectionHeaders',
		'sectionHeaderDictionary',
		'parsedSections',
		'mainSymbolTable',
		'relocationTables',
		'objectSections',
		'relocationParser',
		'convertedSymbols',
		'absoluteSection',
		'commonSection'
	],
	#classVars : [
		'MachineRelocationParsers',
		'SectionParsersForTypes'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #'class initialization' }
SAsmElfLoader class >> initialize [
	super initialize.
	SectionParsersForTypes := Dictionary newFromPairs: { 
		0 . [ :this :sectionHeader :in | ].
		1 . [ :this :sectionHeader :in | this parseProgbitsSection: sectionHeader from: in].
		2 . [ :this :sectionHeader :in | this parseSymbolTableSection: sectionHeader from: in].
		3 . [ :this :sectionHeader :in | this parseStringTableSection: sectionHeader from: in].
		4 . [ :this :sectionHeader :in | this parseRelaSection: sectionHeader from: in].
		5 . [ :this :sectionHeader :in | this parseHashSection: sectionHeader from: in].
		6 . [ :this :sectionHeader :in | this parseDynamicSection: sectionHeader from: in].
		7 . [ :this :sectionHeader :in | this parseNoteSection: sectionHeader from: in].
		8 . [ :this :sectionHeader :in | this parseNobitsSection: sectionHeader from: in].
		9 . [ :this :sectionHeader :in | this parseRelSection: sectionHeader from: in].
		10 . [ :this :sectionHeader :in | this parseShlibSection: sectionHeader from: in].
		11 . [ :this :sectionHeader :in | this parseDynsymSection: sectionHeader from: in].
		14 . [ :this :sectionHeader :in | this parseInitArraySection: sectionHeader from: in].
		15 . [ :this :sectionHeader :in | this parseFiniArraySection: sectionHeader from: in].
		16 . [ :this :sectionHeader :in | this parsePreinitArraySection: sectionHeader from: in].
	}.
	
	MachineRelocationParsers := Dictionary new.
	SAsmElfMachineRelocationParser allSubclassesDo: [ :sc |
		sc machineType ifNotNil: [ :machineType |
			MachineRelocationParsers at: machineType put: sc
		]
	]
]

{ #category : #'as yet unclassified' }
SAsmElfLoader class >> loadFromFileNamed: aFileName [
	| in |
	in := SAsmBinaryReadStream on: (File named: aFileName asFileReference fullName) readStream.
	^ [
		self loadFromStream: in
	] ensure: [ 
		in close
	].
]

{ #category : #'as yet unclassified' }
SAsmElfLoader class >> loadFromStream: in [
	"Check the elf magic number"
	| elfClass |
	(in next: 4) = #[127 69 76 70] ifFalse: [ 
		self error: 'Invalid ELF magic number'
	].

	"Get the elf class"
	elfClass := in next.
	in position: 0.
	elfClass = 16r01 ifTrue: [ 
		^ SAsmElf32Loader new readFrom: in
	].
	elfClass = 16r02 ifTrue: [ 
		^ SAsmElf64Loader new readFrom: in
	].
	
	self error: 'Unsupported elf class.'.

]

{ #category : #'special sections' }
SAsmElfLoader >> absoluteSection [
	^ absoluteSection ifNil: [ absoluteSection := SAsmBinaryObjectSpecialSectionAbsolute new  ]
]

{ #category : #'as yet unclassified' }
SAsmElfLoader >> asBinaryObject [
	^ SAsmBinaryObject new
		sections: objectSections;
		symbols: (convertedSymbols collect: #second thenSelect: #isNotNil);
		compilationTarget: (relocationParser compilationTargetForElfHeader: header);
		yourself
]

{ #category : #'special sections' }
SAsmElfLoader >> commonSection [
	^ commonSection ifNil: [ commonSection := SAsmBinaryObjectSpecialSectionCommon new  ]
]

{ #category : #'as yet unclassified' }
SAsmElfLoader >> convertBinaryObjectRelocations [
	relocationTables do: [ :relocationTable |
		self convertRelocationTable: relocationTable
	]
]

{ #category : #'as yet unclassified' }
SAsmElfLoader >> convertElfSymbolType: elfSymbol [
	elfSymbol type == 2 ifTrue: [ ^ #function ].
	^ #unknown
]

{ #category : #'as yet unclassified' }
SAsmElfLoader >> convertElfSymbolVisibility: elfSymbol [
	elfSymbol binding = 0 ifTrue: [ ^ #private ].
	elfSymbol binding = 1 ifTrue: [ ^ #external ].
	elfSymbol binding = 2 ifTrue: [ ^ #weak ].
	self error: 'Unsupported elf binding type.'
]

{ #category : #'as yet unclassified' }
SAsmElfLoader >> convertRelocationSymbol: symbolIndex withTable: symbolTable [
	| stringTable elfSymbol section symbol sectionAndSymbol |

	convertedSymbols at: symbolIndex ifPresent: [ :cs | ^ cs ].
	
	stringTable := (sectionHeaders at: symbolTable link + 1) content.
	elfSymbol := symbolTable content symbolAt: symbolIndex.
	section := self sectionForElfSymbol: elfSymbol.
	
	elfSymbol name = 0 ifTrue: [ 
		self assert: elfSymbol sectionHeaderIndex ~= 0.
		self assert: elfSymbol value = 0.
		self assert: section isNotNil.
		
		sectionAndSymbol := { section . nil }.
	] ifFalse: [ 
		symbol := SAsmSymbol new
			name: (stringTable getString: elfSymbol name) asSymbol;
			section: section;
			value: elfSymbol value;
			size: elfSymbol size;
			type: (self convertElfSymbolType: elfSymbol);
			visibility: (self convertElfSymbolVisibility: elfSymbol)
			yourself.
		(symbol isUndefined not and: [ symbol isExternal ]) ifTrue: [ 
			symbol makePublic
		].
		sectionAndSymbol := { section . symbol }.
	].

	convertedSymbols at: symbolIndex put: sectionAndSymbol.
	^ sectionAndSymbol
]

{ #category : #'as yet unclassified' }
SAsmElfLoader >> convertRelocationTable: relocationTable [
	| symbolTable relocatedSection convertedEntry sectionAndSymbol |
	symbolTable := sectionHeaders at: relocationTable sectionHeader link + 1.
	relocatedSection := (sectionHeaders at: relocationTable sectionHeader info + 1) content.
	self assert: relocatedSection isSAsmBinaryObjectSection.
	
	relocationTable entries do: [ :entry |
		sectionAndSymbol := self convertRelocationSymbol: entry symbol withTable: symbolTable.
		
		convertedEntry := SAsmBinaryObjectSectionRelocation new
			offset: entry offset;
			addend: entry addend;
			section: sectionAndSymbol first;
			symbol: sectionAndSymbol second;
			yourself.
		relocationParser convertElfRelocation: entry typeInto: convertedEntry.
		relocatedSection addRelocation: convertedEntry
	].
]

{ #category : #'as yet unclassified' }
SAsmElfLoader >> convertSymbolTable [
	| symbolTable |
	symbolTable := sectionHeaderDictionary at: #'.symtab' ifAbsent: [ ^ self ].
	symbolTable content nonLocalSymbols do: [ :symbol |
		self convertRelocationSymbol: symbol index withTable: symbolTable
	].

	symbolTable content localSymbols allButFirstDo: [ :symbol |
		self convertRelocationSymbol: symbol index withTable: symbolTable
	].
]

{ #category : #'format classes' }
SAsmElfLoader >> headerClass [
	self subclassResponsibility
]

{ #category : #parsing }
SAsmElfLoader >> initialize [
	super initialize.
	parsedSections := IdentitySet new.
	objectSections := OrderedCollection new.
	relocationTables := OrderedCollection new.
	convertedSymbols := Dictionary new.
]

{ #category : #parsing }
SAsmElfLoader >> parseDynamicSection: sectionHeader from: in [
]

{ #category : #parsing }
SAsmElfLoader >> parseDynsymSection: sectionHeader from: in [
]

{ #category : #parsing }
SAsmElfLoader >> parseFiniArraySection: sectionHeader from: in [
	^ self parseGenericSection: sectionHeader from: in
]

{ #category : #parsing }
SAsmElfLoader >> parseGenericSection: sectionHeader from: in [
	| data objectSection |
	in position: sectionHeader offset.
	data := in next: sectionHeader contentSize.
	objectSection := SAsmBinaryObjectSection new
		fileOffset: sectionHeader offset;
		name: #unnamed;
		data: data;
		size: sectionHeader contentSize;
		base: sectionHeader address;
		alignment: sectionHeader addressAlign;
		loaded: true;
		readable: sectionHeader isAllocated;
		writeable: sectionHeader isWriteable;
		executable: sectionHeader hasExecutableInstructions;
		yourself.
	sectionHeader content: objectSection.
	objectSections add: objectSection.
]

{ #category : #parsing }
SAsmElfLoader >> parseHashSection: sectionHeader from: in [
]

{ #category : #parsing }
SAsmElfLoader >> parseInitArraySection: sectionHeader from: in [
	^ self parseGenericSection: sectionHeader from: in
]

{ #category : #parsing }
SAsmElfLoader >> parseNobitsSection: sectionHeader from: in [
	| objectSection |
	objectSection := SAsmBinaryObjectSection new
		fileOffset: sectionHeader offset;
		data: nil;
		size: sectionHeader contentSize;
		base: sectionHeader address;
		alignment: sectionHeader addressAlign;
		loaded: false;
		readable: sectionHeader isAllocated;
		writeable: sectionHeader isWriteable;
		executable: sectionHeader hasExecutableInstructions;
		yourself.
	sectionHeader content: objectSection.
	objectSections add: objectSection.
]

{ #category : #parsing }
SAsmElfLoader >> parseNoteSection: sectionHeader from: in [
	^ self parseGenericSection: sectionHeader from: in
]

{ #category : #parsing }
SAsmElfLoader >> parsePreinitArraySection: sectionHeader from: in [
	^ self parseGenericSection: sectionHeader from: in
]

{ #category : #parsing }
SAsmElfLoader >> parseProgbitsSection: sectionHeader from: in [
	^ self parseGenericSection: sectionHeader from: in
]

{ #category : #parsing }
SAsmElfLoader >> parseRelSection: sectionHeader from: in [
	| relocationTable |
	(self parseSection: (sectionHeaders at: sectionHeader link + 1) contentFrom: in) content.
	(self parseSection: (sectionHeaders at: sectionHeader info + 1) contentFrom: in) content.
	
	relocationTable := self relocationTableWithoutAddendsClass new
		fileOffset: sectionHeader offset;
		sectionHeader: sectionHeader;
		readFrom: in;
		yourself.
	relocationTables add: relocationTable
]

{ #category : #parsing }
SAsmElfLoader >> parseRelaSection: sectionHeader from: in [
	| relocationTable |
	(self parseSection: (sectionHeaders at: sectionHeader link + 1) contentFrom: in) content.
	(self parseSection: (sectionHeaders at: sectionHeader info + 1) contentFrom: in) content.
	
	relocationTable := self relocationTableWithAddendsClass new
		fileOffset: sectionHeader offset;
		sectionHeader: sectionHeader;
		readFrom: in;
		yourself.
	relocationTables add: relocationTable.
]

{ #category : #parsing }
SAsmElfLoader >> parseSection: sectionHeader contentFrom: in [
	(parsedSections includes: sectionHeader) ifTrue: [ ^ sectionHeader ].
	parsedSections add: sectionHeader.
	
	SectionParsersForTypes at: sectionHeader type ifPresent: [ :parser |
		parser value: self value: sectionHeader value: in
	] ifAbsent: [ self parseGenericSection: sectionHeader from: in ].

	^ sectionHeader
]

{ #category : #parsing }
SAsmElfLoader >> parseShlibSection: sectionHeader from: in [
]

{ #category : #parsing }
SAsmElfLoader >> parseStringTableSection: sectionHeader from: in [
	in position: sectionHeader offset.
	sectionHeader content: (SAsmBinaryFileCStringTable new setBytes: (in next: sectionHeader contentSize))
]

{ #category : #parsing }
SAsmElfLoader >> parseSymbolTableSection: sectionHeader from: in [
	| stringTable symbolTable |
	stringTable := (self parseSection: (sectionHeaders at: sectionHeader link + 1) contentFrom: in) content.
	symbolTable := self symbolTableClass new
		sectionHeader: sectionHeader;
		fileOffset: sectionHeader offset;
		yourself.
	sectionHeader content: symbolTable.
	symbolTable readFrom: in.
	
	mainSymbolTable ifNil: [
		mainSymbolTable := symbolTable
	].
]

{ #category : #'as yet unclassified' }
SAsmElfLoader >> readFrom: in [
	| sectionHeader sectionHeaderNameTable sectionName relocationParserClass |
	header := self headerClass new
		fileOffset: in position;
		readFrom: in.
	in position: header sectionHeaderOffset.

	"Read the section headers."
	sectionHeaders := (1 to: header sectionHeaderEntries) collect: [ :i |
		sectionHeader := self sectionHeaderClass new
			fileOffset: in position;
			index: i -1;
			readFrom: in.
		in position: sectionHeader fileOffset + header sectionHeaderEntrySize.
		sectionHeader
	].

	"Parse the sections"
	sectionHeaders do: [ :sh |
		self parseSection: sh contentFrom: in.
	].

	"Convert the section names."
	sectionHeaderDictionary := Dictionary new.
	sectionHeaderNameTable := (sectionHeaders at: 1 + header sectionNameStringSectionIndex) content.
	sectionHeaders do: [ :sh |
		sectionName := (sectionHeaderNameTable getString: sh name) asSymbol.
		sectionHeaderDictionary at: sectionName put: sh.
		sh content isSAsmBinaryObjectSection ifTrue: [ 
			sh content name: sectionName
		]
	].
	
	self convertSymbolTable.
	relocationParserClass := MachineRelocationParsers at: header machine ifAbsent: [ nil ].
	relocationParserClass ifNotNil: [
		relocationParser := relocationParserClass new.
		self convertBinaryObjectRelocations
	]

]

{ #category : #'format classes' }
SAsmElfLoader >> relocationTableWithAddendsClass [
	self subclassResponsibility
]

{ #category : #'format classes' }
SAsmElfLoader >> relocationTableWithoutAddendsClass [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
SAsmElfLoader >> sectionForElfSymbol: elfSymbol [
	| sectionIndex |
	sectionIndex := elfSymbol sectionHeaderIndex.
	sectionIndex = 0 ifTrue: [ ^ nil ].
	sectionIndex < 16rff00 ifTrue: [ ^ (sectionHeaders at: sectionIndex + 1) content].
	
	sectionIndex = 16rfff1 ifTrue: [ ^ self absoluteSection ].
	sectionIndex = 16rfff2 ifTrue: [ ^ self commonSection ].
	self error: 'Unsupported special section index.'
]

{ #category : #'format classes' }
SAsmElfLoader >> sectionHeaderClass [
	self subclassResponsibility
]

{ #category : #'format classes' }
SAsmElfLoader >> symbolTableClass [
	self subclassResponsibility
]
