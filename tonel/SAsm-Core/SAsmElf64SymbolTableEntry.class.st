Class {
	#name : #SAsmElf64SymbolTableEntry,
	#superclass : #SLVMElf32SymbolTableEntry,
	#category : #'SAsm-Core-Elf'
}

{ #category : #'as yet unclassified' }
SAsmElf64SymbolTableEntry class >> entrySize [
	^ 24
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
