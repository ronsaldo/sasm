Class {
	#name : #SAsmElf32RelocationEntry,
	#superclass : #Object,
	#instVars : [
		'offset',
		'info'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #'as yet unclassified' }
SAsmElf32RelocationEntry class >> entrySize [
	^ 8
]

{ #category : #accessing }
SAsmElf32RelocationEntry >> info [
	^ info
]

{ #category : #accessing }
SAsmElf32RelocationEntry >> info: anObject [
	info := anObject
]

{ #category : #accessing }
SAsmElf32RelocationEntry >> offset [
	^ offset
]

{ #category : #accessing }
SAsmElf32RelocationEntry >> offset: anObject [
	offset := anObject
]

{ #category : #'as yet unclassified' }
SAsmElf32RelocationEntry >> symbol [
	^ info >> 8
]

{ #category : #'as yet unclassified' }
SAsmElf32RelocationEntry >> symbol: symbol type: type [
	info := (symbol << 8) | type
]

{ #category : #'as yet unclassified' }
SAsmElf32RelocationEntry >> type [
	^ info bitAnd: 16rff
]

{ #category : #'as yet unclassified' }
SAsmElf32RelocationEntry >> writeOn: aStream [
	aStream
		nextPutInt32: offset;
		nextPutInt32: info
]
