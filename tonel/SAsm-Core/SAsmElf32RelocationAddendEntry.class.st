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

{ #category : #reading }
SAsmElf32RelocationAddendEntry >> readFrom: in [
	offset := in uint32.
	info := in uint32.
	addend := in int32.
]

{ #category : #writing }
SAsmElf32RelocationAddendEntry >> writeOn: aStream [
	aStream
		nextPutInt32: offset;
		nextPutInt32: info;
		nextPutInt32: addend
]
