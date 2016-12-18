Class {
	#name : #SAsmElf32Header,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'endianness',
		'osAbi',
		'abiVersion',
		'type',
		'machine',
		'entryPoint',
		'programHeaderOffset',
		'sectionHeaderOffset',
		'flags',
		'programHeaderEntries',
		'sectionHeaderEntries',
		'sectionNameStringSectionIndex'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #accessing }
SAsmElf32Header >> abiVersion [
	^ abiVersion
]

{ #category : #accessing }
SAsmElf32Header >> abiVersion: anObject [
	abiVersion := anObject
]

{ #category : #'elf type' }
SAsmElf32Header >> core [
	type := 4.
]

{ #category : #accessing }
SAsmElf32Header >> endianness [
	^ endianness
]

{ #category : #accessing }
SAsmElf32Header >> endianness: anObject [
	endianness := anObject
]

{ #category : #accessing }
SAsmElf32Header >> entryPoint [
	^ entryPoint
]

{ #category : #accessing }
SAsmElf32Header >> entryPoint: anObject [
	entryPoint := anObject
]

{ #category : #'elf type' }
SAsmElf32Header >> executable [
	type := 2.
]

{ #category : #accessing }
SAsmElf32Header >> flags [
	^ flags
]

{ #category : #accessing }
SAsmElf32Header >> flags: anObject [
	flags := anObject
]

{ #category : #writing }
SAsmElf32Header >> initialize [
	super initialize.
	endianness := 1.
	osAbi := 0.
	abiVersion := 0.
	type := 1.
	machine := 0.
	entryPoint := 0.
	programHeaderOffset := 0.
	sectionHeaderOffset := 0.
	flags := 0.
	programHeaderEntries := 0.
	sectionHeaderEntries := 0.
	sectionNameStringSectionIndex := 0
]

{ #category : #accessing }
SAsmElf32Header >> machine [
	^ machine
]

{ #category : #accessing }
SAsmElf32Header >> machine: anObject [
	machine := anObject
]

{ #category : #accessing }
SAsmElf32Header >> osAbi [
	^ osAbi
]

{ #category : #accessing }
SAsmElf32Header >> osAbi: anObject [
	osAbi := anObject
]

{ #category : #accessing }
SAsmElf32Header >> programHeaderEntries [
	^ programHeaderEntries
]

{ #category : #accessing }
SAsmElf32Header >> programHeaderEntries: anObject [
	programHeaderEntries := anObject
]

{ #category : #writing }
SAsmElf32Header >> programHeaderEntrySize [
	^ 32
]

{ #category : #accessing }
SAsmElf32Header >> programHeaderOffset [
	^ programHeaderOffset
]

{ #category : #accessing }
SAsmElf32Header >> programHeaderOffset: anObject [
	programHeaderOffset := anObject
]

{ #category : #'elf type' }
SAsmElf32Header >> relocatable [
	type := 1.
]

{ #category : #accessing }
SAsmElf32Header >> sectionHeaderEntries [
	^ sectionHeaderEntries
]

{ #category : #accessing }
SAsmElf32Header >> sectionHeaderEntries: anObject [
	sectionHeaderEntries := anObject
]

{ #category : #writing }
SAsmElf32Header >> sectionHeaderEntrySize [
	^ 40
]

{ #category : #accessing }
SAsmElf32Header >> sectionHeaderOffset [
	^ sectionHeaderOffset
]

{ #category : #accessing }
SAsmElf32Header >> sectionHeaderOffset: anObject [
	sectionHeaderOffset := anObject
]

{ #category : #accessing }
SAsmElf32Header >> sectionNameStringSectionIndex [
	^ sectionNameStringSectionIndex
]

{ #category : #accessing }
SAsmElf32Header >> sectionNameStringSectionIndex: anObject [
	sectionNameStringSectionIndex := anObject
]

{ #category : #'elf type' }
SAsmElf32Header >> shared [
	type := 3.
]

{ #category : #accessing }
SAsmElf32Header >> size [
	^ 16r34
]

{ #category : #accessing }
SAsmElf32Header >> type [
	^ type
]

{ #category : #accessing }
SAsmElf32Header >> type: anObject [
	type := anObject
]

{ #category : #writing }
SAsmElf32Header >> writeOn: aStream [
	aStream
		"Magic"
		nextPutInt8: 16r7F;
		nextPutInt8: 16r45;
		nextPutInt8: 16r4c;
		nextPutInt8: 16r46;
		
		"Elf class"
		nextPutInt8: 16r01;

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
		nextPutInt32: entryPoint;
		nextPutInt32: programHeaderOffset;
		nextPutInt32: sectionHeaderOffset;
		nextPutInt32: flags;
		nextPutInt16: self size;
		nextPutInt16: self programHeaderEntrySize;
		nextPutInt16: programHeaderEntries;
		nextPutInt16: self sectionHeaderEntrySize;
		nextPutInt16: sectionHeaderEntries;
		nextPutInt16: sectionNameStringSectionIndex
]
