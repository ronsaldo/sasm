Class {
	#name : #SAsmDWModuleCompilationUnitWriter,
	#superclass : #SAsmDWObject,
	#instVars : [
		'streamBuilder',
		'pointerSize',
		'debugInfoStart',
		'debugInfoEnd',
		'abbreviationsStart',
		'version',
		'compilationUnit',
		'stringTableDictionary',
		'abbreviationsDictionary',
		'abbreviations',
		'debugInformationEntrySymbolDictionary',
		'debugLineStart'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #initialization }
SAsmDWModuleCompilationUnitWriter >> initialize [
	super initialize.
	version := 4.
	stringTableDictionary := OrderedDictionary new.
	debugInformationEntrySymbolDictionary := Dictionary new.
	abbreviationsDictionary := PluggableDictionary new
		hashBlock: #abbreviationHash;
		equalBlock: [:a :b | a abbreviationEquals: b].
	abbreviations := OrderedCollection new.
	
]

{ #category : #writing }
SAsmDWModuleCompilationUnitWriter >> internString: aString [
	stringTableDictionary at: aString ifAbsentPut: [ streamBuilder newPrivateSymbol: #debugString ]
]

{ #category : #accessing }
SAsmDWModuleCompilationUnitWriter >> pointerSize [
	^ pointerSize
]

{ #category : #writing }
SAsmDWModuleCompilationUnitWriter >> prepareForWriting [
	compilationUnit withAllChildrenDo: [ :die |
		debugInformationEntrySymbolDictionary at: die ifAbsentPut: [ streamBuilder newPrivateSymbol: #die ].
		self recordAbbreviation: die.
		die attributesDo: [ :attr | attr prepareForWritingWith: self ]
	]
]

{ #category : #writing }
SAsmDWModuleCompilationUnitWriter >> recordAbbreviation: die [
	| assoc |
	abbreviationsDictionary at: die ifAbsentPut: [
		assoc := (abbreviations size + 1) -> die.
		abbreviations add: assoc.
		assoc.
	]
]

{ #category : #writing }
SAsmDWModuleCompilationUnitWriter >> writeAbbreviations [
	streamBuilder startSection: #'.debug_abbrev' attributes: [ :section |
		section
			loaded: true;
			readable: false;
			debugging: true
	].

	streamBuilder label: abbreviationsStart.
	
	abbreviations do: [ :abrev |
		streamBuilder uleb128: abrev key.
		abrev value writeAbbreviationWith: self to: streamBuilder
	].
	streamBuilder constI8: 0.
	

]

{ #category : #writing }
SAsmDWModuleCompilationUnitWriter >> writeCompilationUnit: aCompilationUnit toStream: aStreamBuilder pointerSize: aPointerSize [
	compilationUnit := aCompilationUnit.
	streamBuilder := aStreamBuilder.
	pointerSize := aPointerSize.

	abbreviationsStart :=	 streamBuilder newPrivateSymbol: #abbreviationsStart.
	debugInfoStart := streamBuilder newPrivateSymbol: #debugInfoStart.
	debugInfoEnd := streamBuilder newPrivateSymbol: #debugInfoEnd.
	debugLineStart := streamBuilder newPrivateSymbol: #debugLineStart.
	
	streamBuilder startSection: #'.debug_line'  attributes: [ :attributes |
		attributes loaded: true;
			readable: false;
			writeable: false;
			executable: false
	].
	streamBuilder label: debugLineStart.
	compilationUnit stmtList: (debugLineStart immediate: pointerSize).
	
	self prepareForWriting.

	self writeStrings.
	self writeAbbreviations.
	self writeDebugInfo.
]

{ #category : #writing }
SAsmDWModuleCompilationUnitWriter >> writeDebugInfo [
	streamBuilder startSection: #'.debug_info' attributes: [ :section |
		section
			loaded: true;
			readable: false;
			debugging: true
	].

	pointerSize = 4 ifTrue: [ 
		streamBuilder constI32: debugInfoEnd dword asSAsmConstantExpression - debugInfoStart dword asSAsmConstantExpression.
	] ifFalse: [ 
		streamBuilder
			constI32: 16rFFFFFFFF;
			constI64: debugInfoEnd qword asSAsmConstantExpression - debugInfoStart qword asSAsmConstantExpression.
	].

	streamBuilder label: debugInfoStart.

	version = 4 ifTrue: [ 
		streamBuilder constI16: 4;
			const: (abbreviationsStart immediate: pointerSize) size: pointerSize;
			constI8: pointerSize.
	].
	version = 5 ifTrue: [ 
		streamBuilder constI16: 5;
			constI8: DW_UT_compile;
			constI8: pointerSize;
			const: (abbreviationsStart immediate: pointerSize) size: pointerSize.
	].

	self writeDebugInfoEntry: compilationUnit.

	streamBuilder label: debugInfoEnd.

]

{ #category : #writing }
SAsmDWModuleCompilationUnitWriter >> writeDebugInfoEntry: debugInfoEntry [
	| abbreviation symbol |
	abbreviation := abbreviationsDictionary at: debugInfoEntry.
	symbol := debugInformationEntrySymbolDictionary at: debugInfoEntry.
	
	streamBuilder
		label: symbol;
		uleb128: abbreviation key.
	
	debugInfoEntry attributesDo: [ :attribute |
		attribute writeAttributeWith: self to: streamBuilder
	].

	debugInfoEntry hasChildren ifTrue: [ 
		debugInfoEntry childrenDo: [ :child | self writeDebugInfoEntry: child ].
		streamBuilder constI8: 0
	].
]

{ #category : #writing }
SAsmDWModuleCompilationUnitWriter >> writeReferenceToDIE: die [
	| symbol |
	symbol := debugInformationEntrySymbolDictionary at: die.
	streamBuilder const: (symbol immediate: pointerSize) size: pointerSize
]

{ #category : #writing }
SAsmDWModuleCompilationUnitWriter >> writeString: string [
	| stringSymbol |
	stringSymbol := stringTableDictionary at: string.
	streamBuilder const: (stringSymbol immediate: pointerSize) size: pointerSize
]

{ #category : #writing }
SAsmDWModuleCompilationUnitWriter >> writeStrings [
	streamBuilder startSection: #'.debug_str' attributes: [ :section |
		section
			loaded: true;
			readable: false;
			debugging: true
	].

	stringTableDictionary keysAndValuesDo: [ :string :symbol |
		streamBuilder label: symbol; cstring: string.
	]
]
