Class {
	#name : #SAsmCoffSectionHeader,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'nameEncoding',
		'virtualSize',
		'virtualAddress',
		'sizeOfRawData',
		'pointerToRawData',
		'pointerToRelocations',
		'pointerToLinenumbers',
		'numberOfRelocations',
		'numberOfLinenumbers',
		'characteristics',
		'content',
		'index',
		'relocationTable'
	],
	#classVars : [
		'AlignmentConstants'
	],
	#pools : [
		'SAsmCoffConstants'
	],
	#category : #'SAsm-Core-Coff'
}

{ #category : #'as yet unclassified' }
SAsmCoffSectionHeader class >> entrySize [
	^ 40
]

{ #category : #initialization }
SAsmCoffSectionHeader class >> initialize [
	AlignmentConstants := { 
		IMAGE_SCN_ALIGN_1BYTES.
		IMAGE_SCN_ALIGN_2BYTES.
		IMAGE_SCN_ALIGN_4BYTES.
		IMAGE_SCN_ALIGN_8BYTES.
		IMAGE_SCN_ALIGN_16BYTES.
		IMAGE_SCN_ALIGN_32BYTES.
		IMAGE_SCN_ALIGN_64BYTES.
		IMAGE_SCN_ALIGN_128BYTES.
		IMAGE_SCN_ALIGN_256BYTES.
		IMAGE_SCN_ALIGN_512BYTES.
		IMAGE_SCN_ALIGN_1024BYTES.
		IMAGE_SCN_ALIGN_2048BYTES.
		IMAGE_SCN_ALIGN_4096BYTES.
		IMAGE_SCN_ALIGN_8192BYTES.
	}
]

{ #category : #properties }
SAsmCoffSectionHeader >> addressAlign: anAlignment [
	| bit |
	bit := AlignmentConstants at: anAlignment highBit.
	characteristics := characteristics | bit
]

{ #category : #properties }
SAsmCoffSectionHeader >> allocated [
]

{ #category : #accessing }
SAsmCoffSectionHeader >> characteristics [
	^ characteristics
]

{ #category : #accessing }
SAsmCoffSectionHeader >> characteristics: anObject [
	characteristics := anObject
]

{ #category : #accessing }
SAsmCoffSectionHeader >> content [
	^ content
]

{ #category : #accessing }
SAsmCoffSectionHeader >> content: anObject [
	content := anObject
]

{ #category : #properties }
SAsmCoffSectionHeader >> executableInstructions [
	characteristics := characteristics | IMAGE_SCN_CNT_CODE | IMAGE_SCN_MEM_EXECUTE
]

{ #category : #accessing }
SAsmCoffSectionHeader >> index [
	^ index
]

{ #category : #accessing }
SAsmCoffSectionHeader >> index: anObject [
	index := anObject
]

{ #category : #initialization }
SAsmCoffSectionHeader >> initialize [
	nameEncoding := ByteArray new: 8.
	virtualSize := 0.
	virtualAddress := 0.
	sizeOfRawData := 0.
	pointerToRawData := 0.
	pointerToRelocations := 0.
	pointerToLinenumbers := 0.
	numberOfRelocations := 0.
	numberOfLinenumbers := 0.
	characteristics := 0.
	
]

{ #category : #accessing }
SAsmCoffSectionHeader >> nameEncoding [
	^ nameEncoding
]

{ #category : #accessing }
SAsmCoffSectionHeader >> nameEncoding: anObject [
	nameEncoding := anObject
]

{ #category : #properties }
SAsmCoffSectionHeader >> nobits [
	characteristics := characteristics | IMAGE_SCN_CNT_UNINITIALIZED_DATA
]

{ #category : #accessing }
SAsmCoffSectionHeader >> numberOfLinenumbers [
	^ numberOfLinenumbers
]

{ #category : #accessing }
SAsmCoffSectionHeader >> numberOfLinenumbers: anObject [
	numberOfLinenumbers := anObject
]

{ #category : #accessing }
SAsmCoffSectionHeader >> numberOfRelocations [
	^ numberOfRelocations
]

{ #category : #accessing }
SAsmCoffSectionHeader >> numberOfRelocations: anObject [
	numberOfRelocations := anObject
]

{ #category : #accessing }
SAsmCoffSectionHeader >> pointerToLinenumbers [
	^ pointerToLinenumbers
]

{ #category : #accessing }
SAsmCoffSectionHeader >> pointerToLinenumbers: anObject [
	pointerToLinenumbers := anObject
]

{ #category : #accessing }
SAsmCoffSectionHeader >> pointerToRawData [
	^ pointerToRawData
]

{ #category : #accessing }
SAsmCoffSectionHeader >> pointerToRawData: anObject [
	pointerToRawData := anObject
]

{ #category : #accessing }
SAsmCoffSectionHeader >> pointerToRelocations [
	^ pointerToRelocations
]

{ #category : #accessing }
SAsmCoffSectionHeader >> pointerToRelocations: anObject [
	pointerToRelocations := anObject
]

{ #category : #writing }
SAsmCoffSectionHeader >> prepareForWritingToFile [
	relocationTable ifNotNil: [ 
		self pointerToRelocations: relocationTable fileOffset.
		self numberOfRelocations: relocationTable numberOfRelocations.
		numberOfRelocations > 16rffff ifTrue: [
			characteristics := characteristics | IMAGE_SCN_LNK_NRELOC_OVFL.
			numberOfRelocations := 16rffff.
		]
	].

	content ifNil: [ ^ self ].
	
	content fileSize = 0 ifTrue: [
		self pointerToRawData: 0.
	] ifFalse: [ 
		self pointerToRawData: content fileOffset.
	].
	self sizeOfRawData: content size.
]

{ #category : #properties }
SAsmCoffSectionHeader >> programBits [
	characteristics := characteristics | IMAGE_SCN_CNT_INITIALIZED_DATA
]

{ #category : #properties }
SAsmCoffSectionHeader >> readable [
	characteristics := characteristics | IMAGE_SCN_MEM_READ
]

{ #category : #accessing }
SAsmCoffSectionHeader >> relocationTable [
	^ relocationTable
]

{ #category : #accessing }
SAsmCoffSectionHeader >> relocationTable: anObject [
	relocationTable := anObject
]

{ #category : #writing }
SAsmCoffSectionHeader >> size [
	^ self class entrySize
]

{ #category : #accessing }
SAsmCoffSectionHeader >> sizeOfRawData [
	^ sizeOfRawData
]

{ #category : #accessing }
SAsmCoffSectionHeader >> sizeOfRawData: anObject [
	sizeOfRawData := anObject
]

{ #category : #accessing }
SAsmCoffSectionHeader >> virtualAddress [
	^ virtualAddress
]

{ #category : #accessing }
SAsmCoffSectionHeader >> virtualAddress: anObject [
	virtualAddress := anObject
]

{ #category : #accessing }
SAsmCoffSectionHeader >> virtualSize [
	^ virtualSize
]

{ #category : #accessing }
SAsmCoffSectionHeader >> virtualSize: anObject [
	virtualSize := anObject
]

{ #category : #writing }
SAsmCoffSectionHeader >> writeOn: aStream [
	aStream
		nextPutAll: nameEncoding;
		nextPutInt32: virtualSize;
		nextPutInt32: virtualAddress;
		nextPutInt32: sizeOfRawData;
		nextPutInt32: pointerToRawData;
		nextPutInt32: pointerToRelocations;
		nextPutInt32: pointerToLinenumbers;
		nextPutInt16: numberOfRelocations;
		nextPutInt16: numberOfLinenumbers;
		nextPutInt32: characteristics
]

{ #category : #properties }
SAsmCoffSectionHeader >> writeable [
	characteristics := characteristics | IMAGE_SCN_MEM_WRITE
]
