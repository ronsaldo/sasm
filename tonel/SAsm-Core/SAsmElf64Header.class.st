Class {
	#name : #SAsmElf64Header,
	#superclass : #SAsmElf32Header,
	#category : #'SAsm-Core-Elf'
}

{ #category : #'as yet unclassified' }
SAsmElf64Header >> elfClass [
	^ 16r02
]

{ #category : #'as yet unclassified' }
SAsmElf64Header >> initialize [
	super initialize.
	elfHeaderSize := 64.
	sectionHeaderEntrySize := 64.
]

{ #category : #'as yet unclassified' }
SAsmElf64Header >> readFrom: in [
	self checkIdentificationHeader: in.
	type := in uint16.
	machine := in uint16.
	"version" in uint32 = 1 ifFalse: [ self error: 'Unsupported elf version' ].
	entryPoint := in uint64.
	programHeaderOffset := in uint64.
	sectionHeaderOffset := in uint64.
	flags := in uint32.
	elfHeaderSize := in uint16.
	programHeaderEntrySize := in uint16.
	programHeaderEntries := in uint16.
	sectionHeaderEntrySize := in uint16.
	sectionHeaderEntries := in uint16.
	sectionNameStringSectionIndex := in uint16.

]

{ #category : #'as yet unclassified' }
SAsmElf64Header >> writeOn: aStream [
	aStream
		"Magic"
		nextPutInt8: 16r7F;
		nextPutInt8: 16r45;
		nextPutInt8: 16r4c;
		nextPutInt8: 16r46;
		
		"Elf class"
		nextPutInt8: 16r02;

		"Endianness"
		nextPutInt8: endianness;
		
		"Version"
		nextPutInt8: 16r01;
		
		nextPutInt8: osAbi;
		nextPutInt8: abiVersion.

	"Padding"
	1 to: 7 do: [:i | aStream nextPutInt8: 16r00 ].
	
	aStream
		nextPutInt16: type;
		nextPutInt16: machine;
		nextPutInt32: 1;
		nextPutInt64: entryPoint;
		nextPutInt64: programHeaderOffset;
		nextPutInt64: sectionHeaderOffset;
		nextPutInt32: flags;
		nextPutInt16: elfHeaderSize;
		nextPutInt16: programHeaderEntrySize;
		nextPutInt16: programHeaderEntries;
		nextPutInt16: sectionHeaderEntrySize;
		nextPutInt16: sectionHeaderEntries;
		nextPutInt16: sectionNameStringSectionIndex
]
