Class {
	#name : #SAsmCoffBuilder,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'sectionHeaders',
		'components',
		'header',
		'symbolTable',
		'stringTable',
		'sectionIndexDictionary',
		'symbolDictionary',
		'sectionContentDictionary',
		'relocationTableDictionary'
	],
	#category : #'SAsm-Core-Coff'
}

{ #category : #adding }
SAsmCoffBuilder >> addSection: content named: sectionName [
	| sectionHeader |
	sectionHeader := SAsmCoffSectionHeader new.
	sectionHeader content: content.
	self setSectionHeader: sectionHeader name: sectionName.
	
	sectionHeaders add: sectionHeader.
	sectionHeader index: sectionHeaders size.
	content ifNotNil: [ 
		components add: content.
		sectionContentDictionary at: content put: sectionHeader.
		sectionIndexDictionary at: content put: sectionHeader index.
	].
	
	
	^ sectionHeader
	
]

{ #category : #adding }
SAsmCoffBuilder >> addSymbol: symbol [
	| coffSymbol |
	symbolTable ifNil: [ ^ self ].
	coffSymbol := symbolTable addSymbol: symbol stringTable: stringTable sectionDictionary: sectionIndexDictionary.
	symbolDictionary at: symbol put: coffSymbol index.
	^ coffSymbol

]

{ #category : #writing }
SAsmCoffBuilder >> allComponentsDo: aBlock [
	aBlock value: header.
	sectionHeaders do: aBlock.
	components do: aBlock.
	
]

{ #category : #writing }
SAsmCoffBuilder >> computeFileBinaryElementsOffsets [
	| offset |
	offset := 0.
	self allComponentsDo: [ :component |
		component fileOffset: offset.
		offset := offset + component fileSize
	]
]

{ #category : #private }
SAsmCoffBuilder >> createSymbolTable [
	symbolTable := SAsmCoffSymbolTable new.
	stringTable := SAsmCoffStringTable new.
	components
		add: symbolTable;
		add: stringTable
]

{ #category : #accessing }
SAsmCoffBuilder >> header [
	^ header
]

{ #category : #adding }
SAsmCoffBuilder >> indexOfRelocationSymbol: symbol section: sectionHeader [
	symbol ifNil: [ 
		^ symbolDictionary at: sectionHeader ifAbsentPut: [ 
			(symbolTable addRelocationSectionSymbol: sectionHeader)
				index
		]
	].

	^ self indexOfSymbol: symbol
]

{ #category : #accessing }
SAsmCoffBuilder >> indexOfSymbol: symbol [
	^ symbolDictionary at: symbol
]

{ #category : #initialization }
SAsmCoffBuilder >> initialize [
	super initialize.
	header := SAsmCoffHeader new.
	sectionHeaders := OrderedCollection new.
	components := OrderedCollection new.
	sectionContentDictionary := IdentityDictionary new.
	sectionIndexDictionary := IdentityDictionary new.
	relocationTableDictionary := IdentityDictionary new.
	symbolDictionary := IdentityDictionary new.
]

{ #category : #writing }
SAsmCoffBuilder >> prepareForWriting [
	self computeFileBinaryElementsOffsets.
	self allComponentsDo: [:component |
		component prepareForWritingToFile
	].

	header numberOfSections: sectionHeaders size.
	symbolTable ifNotNil: [
		header
			numberOfSymbols: symbolTable numberOfSymbols;
			pointerToSymbolTable: symbolTable fileOffset.
	]

]

{ #category : #'as yet unclassified' }
SAsmCoffBuilder >> relocationTableForSection: section [
	| table |
	section relocationTable ifNil: [ 
		table := SAsmCoffRelocationTable new.
		components add: table.
		section relocationTable: table
	].

	^ section relocationTable
]

{ #category : #'as yet unclassified' }
SAsmCoffBuilder >> relocationTableForSectionContent: section [
	^ self relocationTableForSection: (sectionContentDictionary at: section)
]

{ #category : #accessing }
SAsmCoffBuilder >> sectionFromContent: content [
	content ifNil: [ ^ nil ].
	^ sectionContentDictionary at: content
]

{ #category : #adding }
SAsmCoffBuilder >> setSectionHeader: sectionHeader name: sectionName [
	(sectionName size > 8 or: [sectionName first = $/]) ifTrue: [
		self setSectionHeader: sectionHeader shortName: '/' , (stringTable addString: sectionName) asString
	] ifFalse: [ 
		self setSectionHeader: sectionHeader shortName: sectionName
	]

]

{ #category : #adding }
SAsmCoffBuilder >> setSectionHeader: sectionHeader shortName: sectionName [
	1 to: sectionName size do: [ :i |
		sectionHeader nameEncoding at: i put: (sectionName at: i) asInteger
	].

]

{ #category : #writing }
SAsmCoffBuilder >> writeToStream: stream [
	self prepareForWriting.
	self allComponentsDo: [ :el |
		self assert: el fileOffset = stream position.
		el writeOn: stream.
		self assert: el fileOffset + el fileSize = stream position.
	].
]
