Class {
	#name : #SAsmElf32SectionHeader,
	#superclass : #SAsmElfSectionHeader,
	#instVars : [
		'name',
		'type',
		'flags',
		'address',
		'offset',
		'size',
		'link',
		'info',
		'addressAlign',
		'entrySize'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #accessing }
SAsmElf32SectionHeader >> address [
	^ address
]

{ #category : #accessing }
SAsmElf32SectionHeader >> address: anObject [
	address := anObject
]

{ #category : #accessing }
SAsmElf32SectionHeader >> addressAlign [
	^ addressAlign
]

{ #category : #accessing }
SAsmElf32SectionHeader >> addressAlign: anObject [
	addressAlign := anObject
]

{ #category : #flags }
SAsmElf32SectionHeader >> allocated [
	flags := flags | 2
]

{ #category : #accessing }
SAsmElf32SectionHeader >> contentSize [
	^ size
]

{ #category : #accessing }
SAsmElf32SectionHeader >> contentSize: anObject [
	size := anObject
]

{ #category : #types }
SAsmElf32SectionHeader >> dynamics [
	type := 6
]

{ #category : #types }
SAsmElf32SectionHeader >> dynsym [
	type := 11.
	entrySize := 16.
]

{ #category : #accessing }
SAsmElf32SectionHeader >> entrySize [
	^ entrySize
]

{ #category : #flags }
SAsmElf32SectionHeader >> executableInstructions [
	flags := flags | 4
]

{ #category : #accessing }
SAsmElf32SectionHeader >> flags [
	^ flags
]

{ #category : #accessing }
SAsmElf32SectionHeader >> flags: anObject [
	flags := anObject
]

{ #category : #flags }
SAsmElf32SectionHeader >> hasExecutableInstructions [
	^ flags anyMask: 4
]

{ #category : #types }
SAsmElf32SectionHeader >> hash [
	type := 5
]

{ #category : #accessing }
SAsmElf32SectionHeader >> info [
	^ info
]

{ #category : #accessing }
SAsmElf32SectionHeader >> info: anObject [
	info := anObject
]

{ #category : #initialization }
SAsmElf32SectionHeader >> initialize [
	super initialize.
	name := 0.
	type := 0.
	flags := 0.
	address := 0.
	offset := 0.
	size := 0.
	link := 0.
	info := 0.
	addressAlign := 1.
	entrySize := 0.
]

{ #category : #flags }
SAsmElf32SectionHeader >> isAllocated [
	^ flags anyMask: 2
]

{ #category : #flags }
SAsmElf32SectionHeader >> isWriteable [
	^ flags anyMask: 1
]

{ #category : #accessing }
SAsmElf32SectionHeader >> link [
	^ link
]

{ #category : #accessing }
SAsmElf32SectionHeader >> link: anObject [
	link := anObject.
]

{ #category : #accessing }
SAsmElf32SectionHeader >> name [
	^ name
]

{ #category : #accessing }
SAsmElf32SectionHeader >> name: anObject [
	name := anObject
]

{ #category : #types }
SAsmElf32SectionHeader >> nobits [
	type := 8
]

{ #category : #types }
SAsmElf32SectionHeader >> note [
	type := 7
]

{ #category : #accessing }
SAsmElf32SectionHeader >> offset [
	^ offset
]

{ #category : #accessing }
SAsmElf32SectionHeader >> offset: anObject [
	offset := anObject
]

{ #category : #types }
SAsmElf32SectionHeader >> programBits [
	type := 1
]

{ #category : #reading }
SAsmElf32SectionHeader >> readFrom: in [
	name := in uint32.
	type := in uint32.
	flags := in uint32.
	address := in uint32.
	offset := in uint32.
	size := in uint32.
	link := in uint32.
	info := in uint32.
	addressAlign := in uint32.
	entrySize := in uint32.
]

{ #category : #types }
SAsmElf32SectionHeader >> rel [
	type := 9.
	entrySize := 8.
]

{ #category : #types }
SAsmElf32SectionHeader >> rela [
	type := 4.
	entrySize := 12.
]

{ #category : #accessing }
SAsmElf32SectionHeader >> sectionSize [
	^ size
]

{ #category : #flags }
SAsmElf32SectionHeader >> setInfoAndLinkFlags [
	flags := flags | 16r40
]

{ #category : #types }
SAsmElf32SectionHeader >> shlib [
	type := 10
]

{ #category : #accessing }
SAsmElf32SectionHeader >> size [
	^ 40
]

{ #category : #types }
SAsmElf32SectionHeader >> stringTable [
	type := 3
]

{ #category : #types }
SAsmElf32SectionHeader >> symbolTable [
	type := 2.
	entrySize := 16.
]

{ #category : #accessing }
SAsmElf32SectionHeader >> type [
	^ type
]

{ #category : #accessing }
SAsmElf32SectionHeader >> type: anObject [
	type := anObject
]

{ #category : #writing }
SAsmElf32SectionHeader >> writeOn: aStream [
	aStream
		nextPutInt32: name;
		nextPutInt32: type;
		nextPutInt32: flags;
		nextPutInt32: address;
		nextPutInt32: offset;
		nextPutInt32: size;
		nextPutInt32: link;
		nextPutInt32: info;
		nextPutInt32: addressAlign;
		nextPutInt32: entrySize.
]

{ #category : #flags }
SAsmElf32SectionHeader >> writeable [
	flags := flags | 1
]
