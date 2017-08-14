Class {
	#name : #SAsmMachOBuilder,
	#superclass : #Object,
	#instVars : [
		'header',
		'commands',
		'dataComponents',
		'metaDataComponents',
		'symbolTable',
		'segments',
		'symbolDictionary',
		'sections',
		'sectionDictionary'
	],
	#pools : [
		'SAsmMachConstants'
	],
	#category : #'SAsm-Core-MachO'
}

{ #category : #adding }
SAsmMachOBuilder >> addDataComponent: component inSegment: segment [
	| section |
	section := self sectionClass new.
	dataComponents add: component.
	section content: component.
	segment addSection: section.
	
	sections add: section.
	section index: sections size.
	sectionDictionary at: component put: section.
	^ section
]

{ #category : #adding }
SAsmMachOBuilder >> addMetaDataComponent: aComponent [
	metaDataComponents add: aComponent
]

{ #category : #adding }
SAsmMachOBuilder >> addSymbol: aSymbol [
	| machoSymbol |
	symbolTable ifNil: [ ^ self ].
	
	machoSymbol := symbolTable addSymbol: aSymbol sectionDictionary: sectionDictionary.
	symbolDictionary at: aSymbol put: machoSymbol.
]

{ #category : #enumerating }
SAsmMachOBuilder >> allComponentsDo: aBlock [
	aBlock value: header.
	commands do: aBlock.
	metaDataComponents do: aBlock.
	dataComponents do: aBlock.

]

{ #category : #writing }
SAsmMachOBuilder >> computeFileBinaryElementsOffsets [
	| offset |
	offset := 0.
	self allComponentsDo: [ :component |
		component fileOffset: offset.
		offset := offset + component fileSize
	]
]

{ #category : #'as yet unclassified' }
SAsmMachOBuilder >> computeSectionOffsets [
	segments do: #computeSectionOffsets
]

{ #category : #'as yet unclassified' }
SAsmMachOBuilder >> computeSymbolIndices [
	symbolTable ifNotNil: [ symbolTable computeSymbolIndices ]
]

{ #category : #private }
SAsmMachOBuilder >> createSymbolTable [
	| symbolTableStrings symbolTableCommand dySymbolTableCommand |
	symbolTableStrings := SAsmBinaryFileCStringTable new.
	symbolTable := SAsmMachOSymbolTable for: self symbolTableEntryClass.
	symbolTable stringTable: symbolTableStrings.
	
	symbolTableCommand := self symbolTableClass new.
	symbolTableCommand content: symbolTable.
	commands add: symbolTableCommand.
	
	dySymbolTableCommand := self dySymbolTableClass new.
	dySymbolTableCommand symbolTable: symbolTable.
	commands add: dySymbolTableCommand.
	metaDataComponents
		add: symbolTable;
		add: symbolTableStrings.
	^ symbolTable
]

{ #category : #private }
SAsmMachOBuilder >> dySymbolTableClass [
	^ SAsmMachODySymTabCommand
]

{ #category : #accessing }
SAsmMachOBuilder >> header [
	^ header
]

{ #category : #accessing }
SAsmMachOBuilder >> headerClass [
	self subclassResponsibility
]

{ #category : #accessing }
SAsmMachOBuilder >> headerMagic [
	self subclassResponsibility
]

{ #category : #accessing }
SAsmMachOBuilder >> indexOfRelocationSymbol: symbol section: sectionHeader [
	symbol ifNil: [
		^ sectionHeader index
	].

	^ self indexOfSymbol: symbol
]

{ #category : #accessing }
SAsmMachOBuilder >> indexOfSymbol: symbol [
	^ (symbolDictionary at: symbol) index
]

{ #category : #initialization }
SAsmMachOBuilder >> initialize [
	super initialize.
	header := self headerClass new.
	header magic: self headerMagic.
	commands := OrderedCollection new.
	segments := OrderedCollection new.
	sections := OrderedCollection new.
	dataComponents := OrderedCollection new.
	metaDataComponents := OrderedCollection new.
	sectionDictionary := IdentityDictionary new.
	symbolDictionary := IdentityDictionary new.
]

{ #category : #'instance creation' }
SAsmMachOBuilder >> newSegment [
	| segment |
	segment := self segmentClass new.
	segments add: segment.
	commands add: segment.
	^ segment
]

{ #category : #writing }
SAsmMachOBuilder >> prepareForWriting [
	| commandsSize |
	self computeFileBinaryElementsOffsets.
	self allComponentsDo: [:component |
		component prepareForWritingToFile
	].

	commandsSize := 0.
	commands do: [ :cmd | commandsSize := commandsSize + cmd size ].
	header
		ncmds: commands size;
		sizeofcmds: commandsSize
]

{ #category : #'as yet unclassified' }
SAsmMachOBuilder >> relocationTableFor: sectionData [
	| section relocationTable |
	section := sectionDictionary at: sectionData.
	relocationTable := section relocationTable.
	relocationTable ifNotNil: [ ^ relocationTable ].
	
	relocationTable := SAsmMachORelocationTable new.
	metaDataComponents add: relocationTable.
	section relocationTable: relocationTable.
	^ relocationTable
]

{ #category : #accessing }
SAsmMachOBuilder >> sectionClass [
	self subclassResponsibility
]

{ #category : #accessing }
SAsmMachOBuilder >> sectionFromContent: content [
	content ifNil: [ ^ nil ].
	^ sectionDictionary at: content
]

{ #category : #'as yet unclassified' }
SAsmMachOBuilder >> segmentClass [
	self subclassResponsibility
]

{ #category : #initialization }
SAsmMachOBuilder >> setObjectCode [
	header filetype: MH_OBJECT
]

{ #category : #accessing }
SAsmMachOBuilder >> symbolTable [
	^ symbolTable
]

{ #category : #'format classes' }
SAsmMachOBuilder >> symbolTableClass [
	^ SAsmMachOSymTabCommand
]

{ #category : #'format classes' }
SAsmMachOBuilder >> symbolTableEntryClass [
	^ self subclassResponsibility
]

{ #category : #writing }
SAsmMachOBuilder >> writeToStream: stream [
	self prepareForWriting.
	self allComponentsDo: [ :el |
		self assert: el fileOffset = stream position.
		el writeOn: stream.
		self assert: el fileOffset + el fileSize = stream position.
	].
]
