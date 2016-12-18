Class {
	#name : #SAsmElf32RelocationAddendEntry,
	#superclass : #SAsmElf32RelocationEntry,
	#instVars : [
		'addend'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #'as yet unclassified' }
SAsmElf32RelocationAddendEntry class >> entrySize [
	^ 12
]

{ #category : #accessing }
SAsmElf32RelocationAddendEntry >> addend [
	^ addend
]

{ #category : #accessing }
SAsmElf32RelocationAddendEntry >> addend: anObject [
	addend := anObject
]

{ #category : #'as yet unclassified' }
SAsmElf32RelocationAddendEntry >> writeOn: aStream [
	aStream
		nextPutInt32: offset;
		nextPutInt32: info;
		nextPutInt32: addend
]
