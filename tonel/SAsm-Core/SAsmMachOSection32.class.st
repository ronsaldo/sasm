Class {
	#name : #SAsmMachOSection32,
	#superclass : #Object,
	#instVars : [
		'sectname',
		'segname',
		'addr',
		'sectionSize',
		'offset',
		'align',
		'reloff',
		'nreloc',
		'flags',
		'content',
		'index',
		'relocationTable',
		'sectionOffset'
	],
	#pools : [
		'SAsmMachConstants'
	],
	#category : #'SAsm-Core-MachO'
}

{ #category : #accessing }
SAsmMachOSection32 >> addr [
	^ addr
]

{ #category : #accessing }
SAsmMachOSection32 >> addr: anObject [
	addr := anObject
]

{ #category : #accessing }
SAsmMachOSection32 >> align [
	^ align
]

{ #category : #accessing }
SAsmMachOSection32 >> align: anObject [
	align := anObject
]

{ #category : #accessing }
SAsmMachOSection32 >> content [
	^ content
]

{ #category : #accessing }
SAsmMachOSection32 >> content: anObject [
	content := anObject
]

{ #category : #accessing }
SAsmMachOSection32 >> flags [
	^ flags
]

{ #category : #accessing }
SAsmMachOSection32 >> flags: anObject [
	flags := anObject
]

{ #category : #accessing }
SAsmMachOSection32 >> index [
	^ index
]

{ #category : #accessing }
SAsmMachOSection32 >> index: anObject [
	index := anObject
]

{ #category : #initialization }
SAsmMachOSection32 >> initialize [
	super initialize.
	sectname := ByteArray new: 16.
	segname := ByteArray new: 16.
	addr := 0.
	sectionSize := 0.
	offset := 0.
	align := 0.
	reloff := 0.
	nreloc := 0.
	flags := 0.
]

{ #category : #accessing }
SAsmMachOSection32 >> name: aName [
	1 to: sectname size do: [ :i |
		i <= aName size ifTrue: [ 
			sectname at: i put: (aName at: i) asInteger
		] ifFalse: [ 
			sectname at: i put: 0
		]
	]
]

{ #category : #accessing }
SAsmMachOSection32 >> nreloc [
	^ nreloc
]

{ #category : #accessing }
SAsmMachOSection32 >> nreloc: anObject [
	nreloc := anObject
]

{ #category : #accessing }
SAsmMachOSection32 >> offset [
	^ offset
]

{ #category : #accessing }
SAsmMachOSection32 >> offset: anObject [
	offset := anObject
]

{ #category : #writing }
SAsmMachOSection32 >> prepareForWritingToFile [
	relocationTable ifNotNil: [ 
		reloff := relocationTable fileOffset.
		nreloc := relocationTable entryCount.
	].

	content ifNotNil: [ 
		offset := content fileOffset.
		sectionSize := content size
	]
]

{ #category : #'as yet unclassified' }
SAsmMachOSection32 >> pureInstructions [
	flags := flags | S_ATTR_SOME_INSTRUCTIONS | S_ATTR_PURE_INSTRUCTIONS
]

{ #category : #accessing }
SAsmMachOSection32 >> relocationTable [
	^ relocationTable
]

{ #category : #accessing }
SAsmMachOSection32 >> relocationTable: anObject [
	relocationTable := anObject
]

{ #category : #accessing }
SAsmMachOSection32 >> reloff [
	^ reloff
]

{ #category : #accessing }
SAsmMachOSection32 >> reloff: anObject [
	reloff := anObject
]

{ #category : #accessing }
SAsmMachOSection32 >> sectionOffset [
	^ sectionOffset
]

{ #category : #accessing }
SAsmMachOSection32 >> sectionOffset: anObject [
	sectionOffset := anObject
]

{ #category : #accessing }
SAsmMachOSection32 >> sectionSize [
	^ sectionSize
]

{ #category : #accessing }
SAsmMachOSection32 >> sectionSize: anObject [
	sectionSize := anObject
]

{ #category : #accessing }
SAsmMachOSection32 >> sectname [
	^ sectname
]

{ #category : #accessing }
SAsmMachOSection32 >> segmentName: aName [
	1 to: segname size do: [ :i |
		i <= aName size ifTrue: [ 
			segname at: i put: (aName at: i) asInteger
		] ifFalse: [ 
			segname at: i put: 0
		]
	]
]

{ #category : #accessing }
SAsmMachOSection32 >> segname [
	^ segname
]

{ #category : #accessing }
SAsmMachOSection32 >> size [
	^ 68
]

{ #category : #accessing }
SAsmMachOSection32 >> type: aType [
	flags := (flags & SECTION_ATTRIBUTES) | aType

]

{ #category : #'as yet unclassified' }
SAsmMachOSection32 >> withExternalRelocations [
	flags := flags | S_ATTR_EXT_RELOC
]

{ #category : #'as yet unclassified' }
SAsmMachOSection32 >> withLocalRelocations [
	flags := flags | S_ATTR_LOC_RELOC
]

{ #category : #writing }
SAsmMachOSection32 >> writeOn: aStream [
	aStream
		nextPutAll: sectname;
		nextPutAll: segname;
		nextPutInt32: addr;
		nextPutInt32: sectionSize;
		nextPutInt32: offset;
		nextPutInt32: align;
		nextPutInt32: reloff;
		nextPutInt32: nreloc;
		nextPutInt32: flags;
		nextPutInt32: 0;
		nextPutInt32: 0.

]

{ #category : #'as yet unclassified' }
SAsmMachOSection32 >> zeroFill [
	self type: S_ZEROFILL
]
