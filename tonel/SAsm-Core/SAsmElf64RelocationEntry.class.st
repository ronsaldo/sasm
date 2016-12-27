Class {
	#name : #SAsmElf64RelocationEntry,
	#superclass : #SAsmElf32RelocationEntry,
	#category : #'SAsm-Core-Elf'
}

{ #category : #'as yet unclassified' }
SAsmElf64RelocationEntry class >> entrySize [
	^ 16
]

{ #category : #'as yet unclassified' }
SAsmElf64RelocationEntry >> symbol [
	^ info >> 32
]

{ #category : #'as yet unclassified' }
SAsmElf64RelocationEntry >> symbol: symbol type: type [
	info := (symbol << 32) | type
]

{ #category : #'as yet unclassified' }
SAsmElf64RelocationEntry >> type [
	^ info bitAnd: 16rffffffff
]

{ #category : #'as yet unclassified' }
SAsmElf64RelocationEntry >> writeOn: aStream [
	aStream
		nextPutInt64: offset;
		nextPutInt64: info
]
