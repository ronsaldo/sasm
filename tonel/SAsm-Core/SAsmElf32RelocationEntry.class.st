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
SAsmElf32RelocationEntry >> addend [
	^ 0
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

{ #category : #accessing }
SAsmElf32RelocationEntry >> printOn: aStream [
	aStream nextPutAll: 'type: '; print: self type; nextPutAll: ' symbol: '; print: self symbol;
		nextPutAll: ' addend: '; print: self addend;
		nextPutAll: ' offset: '; print: offset
]

{ #category : #reading }
SAsmElf32RelocationEntry >> readFrom: in [
	offset := in uint32.
	info := in uint32.
]

{ #category : #accessing }
SAsmElf32RelocationEntry >> symbol [
	^ info >> 8
]

{ #category : #'as yet unclassified' }
SAsmElf32RelocationEntry >> symbol: symbol type: type [
	info := (symbol << 8) | type
]

{ #category : #accessing }
SAsmElf32RelocationEntry >> type [
	^ info bitAnd: 16rff
]

{ #category : #writing }
SAsmElf32RelocationEntry >> writeOn: aStream [
	aStream
		nextPutInt32: offset;
		nextPutInt32: info
]
