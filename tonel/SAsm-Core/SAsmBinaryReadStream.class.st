Class {
	#name : #SAsmBinaryReadStream,
	#superclass : #ZnBufferedReadStream,
	#instVars : [
		'bigEndian'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #accessing }
SAsmBinaryReadStream >> bigEndian [
	^ bigEndian
]

{ #category : #accessing }
SAsmBinaryReadStream >> bigEndian: anObject [
	bigEndian := anObject
]

{ #category : #initialization }
SAsmBinaryReadStream >> initialize [
	super initialize.
	bigEndian := false.
]

{ #category : #'accessing-bytes' }
SAsmBinaryReadStream >> int16 [
	^ self nextIntegerOfSize: 2 signed: true bigEndian: bigEndian
]

{ #category : #'accessing-bytes' }
SAsmBinaryReadStream >> int32 [
	^ self nextIntegerOfSize: 4 signed: true bigEndian: bigEndian
]

{ #category : #'accessing-bytes' }
SAsmBinaryReadStream >> int64 [
	^ self nextIntegerOfSize: 8 signed: true bigEndian: bigEndian 
]

{ #category : #'accessing-bytes' }
SAsmBinaryReadStream >> int8 [
	^ self nextIntegerOfSize: 1 signed: true bigEndian: bigEndian 
]

{ #category : #'accessing-bytes' }
SAsmBinaryReadStream >> uint16 [
	^ self nextIntegerOfSize: 2 signed: false bigEndian: bigEndian 
]

{ #category : #'accessing-bytes' }
SAsmBinaryReadStream >> uint32 [
	^ self nextIntegerOfSize: 4 signed: false bigEndian: bigEndian 
]

{ #category : #'accessing-bytes' }
SAsmBinaryReadStream >> uint64 [
	^ self nextIntegerOfSize: 8 signed: false bigEndian: bigEndian 
]

{ #category : #'accessing-bytes' }
SAsmBinaryReadStream >> uint8 [
	^ self nextIntegerOfSize: 1 signed: false bigEndian: bigEndian
]
