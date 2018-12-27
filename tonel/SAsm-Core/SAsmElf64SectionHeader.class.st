Class {
	#name : #SAsmElf64SectionHeader,
	#superclass : #SAsmElf32SectionHeader,
	#category : #'SAsm-Core-Elf'
}

{ #category : #types }
SAsmElf64SectionHeader >> dynsym [
	type := 11.
	entrySize := 24.
]

{ #category : #writing }
SAsmElf64SectionHeader >> readFrom: in [
	name := in uint32.
	type := in uint32.
	flags := in uint64.
	address := in uint64.
	offset := in uint64.
	size := in uint64.
	link := in uint32.
	info := in uint32.
	addressAlign := in uint64.
	entrySize := in uint64.

]

{ #category : #types }
SAsmElf64SectionHeader >> rel [
	type := 9.
	entrySize := 16.
]

{ #category : #types }
SAsmElf64SectionHeader >> rela [
	type := 4.
	entrySize := 24.
]

{ #category : #accessing }
SAsmElf64SectionHeader >> size [
	^ 64
]

{ #category : #types }
SAsmElf64SectionHeader >> symbolTable [
	type := 2.
	entrySize := 24.
]

{ #category : #writing }
SAsmElf64SectionHeader >> writeOn: aStream [
	aStream
		nextPutInt32: name;
		nextPutInt32: type;
		nextPutInt64: flags;
		nextPutInt64: address;
		nextPutInt64: offset;
		nextPutInt64: size;
		nextPutInt32: link;
		nextPutInt32: info;
		nextPutInt64: addressAlign;
		nextPutInt64: entrySize.
]
