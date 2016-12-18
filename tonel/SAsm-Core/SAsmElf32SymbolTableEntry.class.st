Class {
	#name : #SAsmElf32SymbolTableEntry,
	#superclass : #Object,
	#instVars : [
		'name',
		'value',
		'size',
		'info',
		'other',
		'sectionHeaderIndex',
		'index'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #'as yet unclassified' }
SAsmElf32SymbolTableEntry class >> entrySize [
	^ 16
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> index [
	^ index
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> index: anObject [
	index := anObject
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> info [
	^ info
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> info: anObject [
	info := anObject
]

{ #category : #initialization }
SAsmElf32SymbolTableEntry >> initialize [
	super initialize.
	name := 0.
	value := 0.
	size := 0.
	info := 0.
	other := 0.
	sectionHeaderIndex := 0.
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> name [
	^ name
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> other [
	^ other
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> other: anObject [
	other := anObject
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> sectionHeaderIndex [
	^ sectionHeaderIndex
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> sectionHeaderIndex: anObject [
	sectionHeaderIndex := anObject
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> size [
	^ size
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> size: anObject [
	size := anObject
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> value [
	^ value
]

{ #category : #accessing }
SAsmElf32SymbolTableEntry >> value: anObject [
	value := anObject
]

{ #category : #writing }
SAsmElf32SymbolTableEntry >> writeOn: aStream [
	aStream
		nextPutInt32: name;
		nextPutInt32: value;
		nextPutInt32: size;
		nextPutInt8: info;
		nextPutInt8: other;
		nextPutInt16: sectionHeaderIndex.
]
