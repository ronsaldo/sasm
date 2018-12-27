Class {
	#name : #SAsmElf64SymbolTableEntry,
	#superclass : #SAsmElf32SymbolTableEntry,
	#category : #'SAsm-Core-Elf'
}

{ #category : #'as yet unclassified' }
SAsmElf64SymbolTableEntry class >> entrySize [
	^ 24
]

{ #category : #reading }
SAsmElf64SymbolTableEntry >> readFrom: in [
	name := in uint32.
	info := in uint8.
	other := in uint8.
	sectionHeaderIndex := in uint16.
	value := in uint64.
	size := in uint64.

]

{ #category : #writing }
SAsmElf64SymbolTableEntry >> writeOn: aStream [
	aStream
		nextPutInt32: name;
		nextPutInt8: info;
		nextPutInt8: other;
		nextPutInt16: sectionHeaderIndex;
		nextPutInt64: value;
		nextPutInt64: size.
]
