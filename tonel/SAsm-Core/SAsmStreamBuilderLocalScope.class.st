Class {
	#name : #SAsmStreamBuilderLocalScope,
	#superclass : #Object,
	#instVars : [
		'parent',
		'table',
		'nameTable'
	],
	#category : #'SAsm-Core-Builder'
}

{ #category : #'as yet unclassified' }
SAsmStreamBuilderLocalScope class >> empty [
	^ self new
]

{ #category : #'as yet unclassified' }
SAsmStreamBuilderLocalScope class >> parent: aParentScope [
	^ self new parent: aParentScope; yourself
]

{ #category : #adding }
SAsmStreamBuilderLocalScope >> addMapToObject: anObject symbol: symbol [
	table at: anObject put: symbol.
	symbol name ifNotNil: [ nameTable at: symbol name put: symbol ]
]

{ #category : #adding }
SAsmStreamBuilderLocalScope >> addNamedSymbol: symbol [
	self assert: symbol name isNotNil.
	nameTable at: symbol name put: symbol
]

{ #category : #'as yet unclassified' }
SAsmStreamBuilderLocalScope >> findMappedSymbolRecursively: anObject [
	anObject isSAsmSymbol ifTrue: [ ^ anObject ].
	^ self findMappedSymbolRecursively: anObject ifAbsent: [ 
		self error: 'Failed to find symbol for object ' , anObject printString
	]
]

{ #category : #'as yet unclassified' }
SAsmStreamBuilderLocalScope >> findMappedSymbolRecursively: anObject ifAbsent: absentBlock [
	^ table at: anObject ifAbsent: [
		parent ifNil: [ ^ absentBlock value ].
		^ parent findMappedSymbolRecursively: anObject ifAbsent: absentBlock
	]
]

{ #category : #'as yet unclassified' }
SAsmStreamBuilderLocalScope >> findNamedSymbolRecursively: aName ifAbsent: absentBlock [
	^ nameTable at: aName ifAbsent: [
		parent ifNil: [ ^ absentBlock value ].
		^ parent findNamedSymbolRecursively: aName ifAbsent: absentBlock
	]
]

{ #category : #initialization }
SAsmStreamBuilderLocalScope >> initialize [
	super initialize.
	table := Dictionary new.
	nameTable := Dictionary new.
]

{ #category : #accessing }
SAsmStreamBuilderLocalScope >> parent [
	^ parent
]

{ #category : #accessing }
SAsmStreamBuilderLocalScope >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
SAsmStreamBuilderLocalScope >> table [
	^ table
]

{ #category : #'as yet unclassified' }
SAsmStreamBuilderLocalScope >> topScope [
	^ parent ifNil: [ self ] ifNotNil: [ parent topScope ]
]
