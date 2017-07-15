Class {
	#name : #SAsmCoffSymbolTableEntry,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'nameEncoding',
		'value',
		'sectionNumber',
		'type',
		'storageClass',
		'numberOfAuxSymbols',
		'index'
	],
	#category : #'SAsm-Core-Coff'
}

{ #category : #'as yet unclassified' }
SAsmCoffSymbolTableEntry class >> entrySize [
	^ 18
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> index [
	^ index
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> index: anObject [
	index := anObject
]

{ #category : #writing }
SAsmCoffSymbolTableEntry >> initialize [
	nameEncoding := ByteArray new: 8.
	value := 0.
	sectionNumber := 0.
	type := 0.
	storageClass := 0.
	numberOfAuxSymbols := 0.
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> nameEncoding [
	^ nameEncoding
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> nameEncoding: anObject [
	nameEncoding := anObject
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> numberOfAuxSymbols [
	^ numberOfAuxSymbols
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> numberOfAuxSymbols: anObject [
	numberOfAuxSymbols := anObject
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> sectionNumber [
	^ sectionNumber
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> sectionNumber: anObject [
	sectionNumber := anObject
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> size [
	^ self class entrySize
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> storageClass [
	^ storageClass
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> storageClass: anObject [
	storageClass := anObject
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> type [
	^ type
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> type: anObject [
	type := anObject
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> value1 [
	^ value
]

{ #category : #accessing }
SAsmCoffSymbolTableEntry >> value: anObject [
	value := anObject
]

{ #category : #writing }
SAsmCoffSymbolTableEntry >> writeOn: aStream [
	aStream
		nextPutAll: nameEncoding;
		nextPutInt32: value;
		nextPutInt16: sectionNumber;
		nextPutInt16: type;
		nextPutInt8: storageClass;
		nextPutInt8: numberOfAuxSymbols
]
