"
I am a dummy binary object writer. I am used for computing the size of instructions.
"
Class {
	#name : #SAsmBinaryObjectDummyWriter,
	#superclass : #Object,
	#instVars : [
		'size',
		'target'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #testing }
SAsmBinaryObjectDummyWriter >> isLongMode [
	^ target isLongMode
]

{ #category : #testing }
SAsmBinaryObjectDummyWriter >> isShortMode [
	^ target isShortMode
]

{ #category : #stream }
SAsmBinaryObjectDummyWriter >> nextPut: aByte [
	size := size + 1
]

{ #category : #stream }
SAsmBinaryObjectDummyWriter >> nextPutAll: aCollection [
	size := size + aCollection size
]

{ #category : #stream }
SAsmBinaryObjectDummyWriter >> nextPutC8: aByte [
	size := size + 1
]

{ #category : #stream }
SAsmBinaryObjectDummyWriter >> nextPutI16: immediate [
	size := size + 2
]

{ #category : #stream }
SAsmBinaryObjectDummyWriter >> nextPutI32: immediate [
	size := size + 4
]

{ #category : #stream }
SAsmBinaryObjectDummyWriter >> nextPutI64: immediate [
	size := size + 8
]

{ #category : #stream }
SAsmBinaryObjectDummyWriter >> nextPutI8: immediate [
	size := size + 1
]

{ #category : #stream }
SAsmBinaryObjectDummyWriter >> nextPutIPRelativeBranch32: immediate [
	size := size + 4
]

{ #category : #stream }
SAsmBinaryObjectDummyWriter >> nextPutIPRelativeI32: immediate [
	size := size + 4
]

{ #category : #stream }
SAsmBinaryObjectDummyWriter >> nextPutIPRelativeI32: displacement extraOffset: extraOffset [
	size := size + 4
]

{ #category : #stream }
SAsmBinaryObjectDummyWriter >> nextPutIPRelativeI8: immediate [
	size := size + 1
]

{ #category : #stream }
SAsmBinaryObjectDummyWriter >> reset [
	size := 0
]

{ #category : #accessing }
SAsmBinaryObjectDummyWriter >> size [
	^ size
]

{ #category : #accessing }
SAsmBinaryObjectDummyWriter >> size: anObject [
	size := anObject
]

{ #category : #accessing }
SAsmBinaryObjectDummyWriter >> target [
	^ target
]

{ #category : #accessing }
SAsmBinaryObjectDummyWriter >> target: anObject [
	target := anObject
]
