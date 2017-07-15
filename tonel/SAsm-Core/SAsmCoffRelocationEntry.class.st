Class {
	#name : #SAsmCoffRelocationEntry,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'virtualAddress',
		'symbolTableIndex',
		'type'
	],
	#category : #'SAsm-Core-Coff'
}

{ #category : #'as yet unclassified' }
SAsmCoffRelocationEntry class >> entrySize [
	^ 10
]

{ #category : #writing }
SAsmCoffRelocationEntry >> size [
	^ self class entrySize
]

{ #category : #accessing }
SAsmCoffRelocationEntry >> symbolTableIndex [
	^ symbolTableIndex
]

{ #category : #accessing }
SAsmCoffRelocationEntry >> symbolTableIndex: anObject [
	symbolTableIndex := anObject
]

{ #category : #accessing }
SAsmCoffRelocationEntry >> type [
	^ type
]

{ #category : #accessing }
SAsmCoffRelocationEntry >> type: anObject [
	type := anObject
]

{ #category : #accessing }
SAsmCoffRelocationEntry >> virtualAddress [
	^ virtualAddress
]

{ #category : #accessing }
SAsmCoffRelocationEntry >> virtualAddress: anObject [
	virtualAddress := anObject
]

{ #category : #writing }
SAsmCoffRelocationEntry >> writeOn: aStream [
	aStream
		nextPutInt32: virtualAddress;
		nextPutInt32: symbolTableIndex;
		nextPutInt16: type
]
