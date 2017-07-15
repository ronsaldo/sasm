Class {
	#name : #SAsmCoffHeader,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'machine',
		'numberOfSections',
		'timeDateStamp',
		'pointerToSymbolTable',
		'numberOfSymbols',
		'sizeOfOptionalHeader',
		'characteristics'
	],
	#category : #'SAsm-Core-Coff'
}

{ #category : #accessing }
SAsmCoffHeader >> characteristics [
	^ characteristics
]

{ #category : #accessing }
SAsmCoffHeader >> characteristics: anObject [
	characteristics := anObject
]

{ #category : #writing }
SAsmCoffHeader >> initialize [
	machine := 0.
	numberOfSections := 0.
	timeDateStamp := 0.
	pointerToSymbolTable := 0.
	numberOfSymbols := 0.
	sizeOfOptionalHeader := 0.
	characteristics := 0.
]

{ #category : #accessing }
SAsmCoffHeader >> machine [
	^ machine
]

{ #category : #accessing }
SAsmCoffHeader >> machine: anObject [
	machine := anObject
]

{ #category : #accessing }
SAsmCoffHeader >> numberOfSections [
	^ numberOfSections
]

{ #category : #accessing }
SAsmCoffHeader >> numberOfSections: anObject [
	numberOfSections := anObject
]

{ #category : #accessing }
SAsmCoffHeader >> numberOfSymbols [
	^ numberOfSymbols
]

{ #category : #accessing }
SAsmCoffHeader >> numberOfSymbols: anObject [
	numberOfSymbols := anObject
]

{ #category : #accessing }
SAsmCoffHeader >> pointerToSymbolTable [
	^ pointerToSymbolTable
]

{ #category : #accessing }
SAsmCoffHeader >> pointerToSymbolTable: anObject [
	pointerToSymbolTable := anObject
]

{ #category : #writing }
SAsmCoffHeader >> size [
	^ 20
]

{ #category : #accessing }
SAsmCoffHeader >> sizeOfOptionalHeader [
	^ sizeOfOptionalHeader
]

{ #category : #accessing }
SAsmCoffHeader >> sizeOfOptionalHeader: anObject [
	sizeOfOptionalHeader := anObject
]

{ #category : #accessing }
SAsmCoffHeader >> timeDateStamp [
	^ timeDateStamp
]

{ #category : #accessing }
SAsmCoffHeader >> timeDateStamp: anObject [
	timeDateStamp := anObject
]

{ #category : #writing }
SAsmCoffHeader >> writeOn: aStream [
	aStream
		nextPutInt16: machine;
		nextPutInt16: numberOfSections;
		nextPutInt32: timeDateStamp;
		nextPutInt32: pointerToSymbolTable;
		nextPutInt32: numberOfSymbols;
		nextPutInt16: sizeOfOptionalHeader;
		nextPutInt16: characteristics.
]
