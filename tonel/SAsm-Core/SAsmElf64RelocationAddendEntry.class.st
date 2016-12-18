Class {
	#name : #SAsmElf64RelocationAddendEntry,
	#superclass : #SAsmElf64RelocationEntry,
	#instVars : [
		'addend'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #'as yet unclassified' }
SAsmElf64RelocationAddendEntry class >> entrySize [
	^ 24
]

{ #category : #accessing }
SAsmElf64RelocationAddendEntry >> addend [
	^ addend
]

{ #category : #accessing }
SAsmElf64RelocationAddendEntry >> addend: anObject [
	addend := anObject
]

{ #category : #'as yet unclassified' }
SAsmElf64RelocationAddendEntry >> writeOn: aStream [
	aStream
		nextPutInt64: offset;
		nextPutInt64: info;
		nextPutInt64: addend
]
