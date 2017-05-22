Class {
	#name : #SAsmStreamBuilderLocalScope,
	#superclass : #Object,
	#instVars : [
		'parent',
		'table'
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

{ #category : #'as yet unclassified' }
SAsmStreamBuilderLocalScope >> addMapToObject: anObject symbol: symbol [
	table at: anObject put: symbol
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
SAsmStreamBuilderLocalScope >> initialize [
	super initialize.
	table := Dictionary new.
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
