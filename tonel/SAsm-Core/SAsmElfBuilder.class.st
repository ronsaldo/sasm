Class {
	#name : #SAsmElfBuilder,
	#superclass : #Object,
	#instVars : [
		'components',
		'header',
		'sectionNameTable',
		'sections',
		'symbolStringTable',
		'symbolTable',
		'dynSymbolStringTable',
		'dynSymbolTable',
		'firstComponents',
		'sectionIndexDictionary',
		'sectionDictionary',
		'relocationSectionDictionary',
		'symbolDictionary',
		'sectionContentDictionary'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #adding }
SAsmElfBuilder >> addComponent: component [
	components add: component.
	^ component
]

{ #category : #adding }
SAsmElfBuilder >> addComponent: component sectionNamed: sectionNamed [
	^ self addSectionNamed: sectionNamed content: (self addComponent: component)
]

{ #category : #adding }
SAsmElfBuilder >> addDynamicSymbol: symbol [
	dynSymbolTable ifNil: [ ^ nil ].
	dynSymbolTable addSymbol: symbol stringTable: dynSymbolStringTable sectionDictionary: sectionIndexDictionary
]

{ #category : #adding }
SAsmElfBuilder >> addFirstComponent: component [
	firstComponents add: component.
	^ component
]

{ #category : #adding }
SAsmElfBuilder >> addFirstComponent: component sectionNamed: sectionNamed [
	^ self addSectionNamed: sectionNamed content: (self addFirstComponent: component)
]

{ #category : #adding }
SAsmElfBuilder >> addNormalSymbol: symbol [
	| elfSymbol |
	symbolTable ifNil: [ ^ nil ].
	elfSymbol := symbolTable addSymbol: symbol stringTable: symbolStringTable sectionDictionary: sectionIndexDictionary.
	symbolDictionary at: symbol put: elfSymbol index.
]

{ #category : #adding }
SAsmElfBuilder >> addSectionNamed: sectionName [
	^ self addSectionNamed: sectionName content: nil
]

{ #category : #adding }
SAsmElfBuilder >> addSectionNamed: sectionName content: content [
	| section |
	section := self sectionHeaderClass new
		name: (sectionNameTable addString: sectionName);
		content: content;
		index: sections size.
	sections add: section.
	content ifNotNil: [
		sectionContentDictionary at: content put: section.
		sectionIndexDictionary at: content put: section index.
	].
	^ section
]

{ #category : #adding }
SAsmElfBuilder >> addSymbol: symbol [
	self addDynamicSymbol: symbol;
		addNormalSymbol: symbol
]

{ #category : #writing }
SAsmElfBuilder >> allComponentsDo: aBlock [
	aBlock value: header.
	firstComponents do: aBlock.
	components do: aBlock.
	sections do: aBlock.
]

{ #category : #'as yet unclassified' }
SAsmElfBuilder >> binaryData [
	| stream |
	stream := SLVMLirBinaryStream on: (ByteArray new: 100).
	self writeToStream: stream.
	^ stream contents
]

{ #category : #'as yet unclassified' }
SAsmElfBuilder >> computeFileBinaryElementsOffsets [
	| offset |
	offset := 0.
	self allComponentsDo: [ :component |
		component fileOffset: offset.
		offset := offset + component size
	]
]

{ #category : #adding }
SAsmElfBuilder >> createDynSymbolTable [
	| stringTableSection |
	dynSymbolStringTable := self addComponent: self stringTableClass new.
	stringTableSection := (self addSectionNamed: '.dynstr' content: dynSymbolStringTable)
		stringTable.
		
	dynSymbolTable := self addComponent: self symbolTableClass new.
	symbolTable sectionHeader: ((self addSectionNamed: '.dyntab' content: dynSymbolTable)
		link: stringTableSection index;
		addressAlign: self pointerAlignment;
		dynsym;
		allocated)
]

{ #category : #adding }
SAsmElfBuilder >> createSymbolTable [
	| stringTableSection |
	symbolStringTable := self addComponent: self stringTableClass new.
	stringTableSection := (self addSectionNamed: '.strtab' content: symbolStringTable)
		stringTable.
		
	symbolTable := self addComponent: self symbolTableClass new.
	symbolTable sectionHeader: ((self addSectionNamed: '.symtab' content: symbolTable)
		link: stringTableSection index;
		addressAlign: self pointerAlignment;
		symbolTable;
		allocated).
]

{ #category : #accessing }
SAsmElfBuilder >> header [
	^ header
]

{ #category : #'format classes' }
SAsmElfBuilder >> headerClass [
	self subclassResponsibility
]

{ #category : #accessing }
SAsmElfBuilder >> indexOfRelocationSymbol: symbol section: section [
	symbol ifNil: [ 
		^ symbolDictionary at: section ifAbsentPut: [ 
			(symbolTable addRelocationSectionSymbol: section)
				index
		]
	].

	^ self indexOfSymbol: symbol
]

{ #category : #accessing }
SAsmElfBuilder >> indexOfSymbol: symbol [
	^ symbolDictionary at: symbol
]

{ #category : #initialization }
SAsmElfBuilder >> initialize [
	super initialize.
	firstComponents := OrderedCollection new.
	components := OrderedCollection new.
	sections := OrderedCollection new.
	sectionContentDictionary := IdentityDictionary new.
	sectionIndexDictionary := IdentityDictionary new.
	relocationSectionDictionary := IdentityDictionary new.
	symbolDictionary := IdentityDictionary new.
	sections add: self sectionHeaderClass new.	"Null section."
		
	header := self headerClass new.
	sectionNameTable := self addComponent: self stringTableClass new.
	(self addSectionNamed: '.shstrtab' content: sectionNameTable)
		stringTable.
]

{ #category : #accessing }
SAsmElfBuilder >> pointerAlignment [
	self subclassResponsibility
]

{ #category : #writing }
SAsmElfBuilder >> prepareForWriting [
	self computeFileBinaryElementsOffsets.
	self allComponentsDo: [:component |
		component prepareForWritingToFile
	].

	header
		sectionHeaderOffset: sections first fileOffset;
		sectionHeaderEntries: sections size;
		sectionNameStringSectionIndex: 1.
]

{ #category : #'format classes' }
SAsmElfBuilder >> programHeaderClass [
	self subclassResponsibility
]

{ #category : #adding }
SAsmElfBuilder >> relocationSectionFor: section [
	^ (relocationSectionDictionary at: section ifAbsentPut: [
		(self addSectionNamed: ('.rel' , section name) asSymbol content: (self addComponent: self relocationTableClass new))
			rel;
			setInfoAndLinkFlags;
			addressAlign: self pointerAlignment;
			link: (sectionIndexDictionary at: symbolTable);
			info: (sectionIndexDictionary at: section);
			yourself
	]) content
]

{ #category : #'format classes' }
SAsmElfBuilder >> relocationTableClass [
	self subclassResponsibility
]

{ #category : #adding }
SAsmElfBuilder >> relocationWithAddendSectionFor: section [
	^ (relocationSectionDictionary at: section ifAbsentPut: [
		(self addSectionNamed: ('.rela' , section name) asSymbol content: (self addComponent: self relocationWithAddendTableClass new))
			rela;
			setInfoAndLinkFlags;
			addressAlign: self pointerAlignment;
			link: (sectionIndexDictionary at: symbolTable);
			info: (sectionIndexDictionary at: section);
			yourself
	]) content
]

{ #category : #'format classes' }
SAsmElfBuilder >> relocationWithAddendTableClass [
	self subclassResponsibility
]

{ #category : #accessing }
SAsmElfBuilder >> sectionFromContent: content [
	content ifNil: [ ^ nil ].
	^ sectionContentDictionary at: content
]

{ #category : #'format classes' }
SAsmElfBuilder >> sectionHeaderClass [
	self subclassResponsibility
]

{ #category : #'format classes' }
SAsmElfBuilder >> stringTableClass [
	self subclassResponsibility
]

{ #category : #'format classes' }
SAsmElfBuilder >> symbolTableClass [
	self subclassResponsibility
]

{ #category : #'format classes' }
SAsmElfBuilder >> symbolTableEntryClass [
	self subclassResponsibility
]

{ #category : #writing }
SAsmElfBuilder >> writeToFileNamed: fileName [
	| data |
	data := self binaryData.
	fileName asFileReference writeStreamDo: [ :out |
		out truncate; binary; nextPutAll: data
	]
]

{ #category : #writing }
SAsmElfBuilder >> writeToStream: stream [
	self prepareForWriting.
	self allComponentsDo: [ :el | el writeOn: stream ].
]
