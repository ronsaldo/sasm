Class {
	#name : #SAsmMachORelocationInfo,
	#superclass : #Object,
	#instVars : [
		'address',
		'encodedValue'
	],
	#pools : [
		'SAsmMachConstants'
	],
	#category : #'SAsm-Core-MachO'
}

{ #category : #'as yet unclassified' }
SAsmMachORelocationInfo class >> entrySize [
	^ 8
]

{ #category : #accessing }
SAsmMachORelocationInfo >> address [
	^ address
]

{ #category : #accessing }
SAsmMachORelocationInfo >> address: anObject [
	address := anObject
]

{ #category : #accessing }
SAsmMachORelocationInfo >> encodedValue [
	^ encodedValue
]

{ #category : #accessing }
SAsmMachORelocationInfo >> encodedValue: anObject [
	encodedValue := anObject
]

{ #category : #accessing }
SAsmMachORelocationInfo >> size [
	^ self class entrySize 
]

{ #category : #'as yet unclassified' }
SAsmMachORelocationInfo >> symbolnum: symbolnum pcrel: pcrel length: length extern: extern type: type [.
	encodedValue := symbolnum | (pcrel asBit << 24) | (length << 25) | (extern asBit << 27) | (type << 28)
]

{ #category : #writing }
SAsmMachORelocationInfo >> writeOn: aStream [
	aStream
		nextPutInt32: address;
		nextPutInt32: encodedValue
]
