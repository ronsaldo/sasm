"
I am a virtual three address code instruction. I am used as an intermediate code representation before register allocation.
"
Class {
	#name : #SAsmTacInstruction,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'operation',
		'result',
		'left',
		'right'
	],
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacInstruction >> accept: aVisitor [
	^ aVisitor visitTacInstruction: self
]

{ #category : #testing }
SAsmTacInstruction >> isThreeAddressInstruction [
	^ true
]

{ #category : #accessing }
SAsmTacInstruction >> left [
	^ left
]

{ #category : #accessing }
SAsmTacInstruction >> left: anObject [
	left := anObject
]

{ #category : #'as yet unclassified' }
SAsmTacInstruction >> markVirtualRegisterLiveRanges [
	result ifNotNil: [ result markVirtualRegisterLiveRangePosition: index ].
	left ifNotNil: [ left markVirtualRegisterLiveRangePosition: index ].
	right ifNotNil: [ right markVirtualRegisterLiveRangePosition: index ].

]

{ #category : #accessing }
SAsmTacInstruction >> operation [
	^ operation
]

{ #category : #accessing }
SAsmTacInstruction >> operation: anObject [
	operation := anObject
]

{ #category : #printing }
SAsmTacInstruction >> prettyPrintOn: aStream [
	result ifNotNil: [ 
		result prettyPrintOn: aStream.
		aStream nextPutAll: ' := '
	].
	
	right ifNotNil: [ 
		left prettyPrintOn: aStream.
		aStream space.
		operation prettyPrintOn: aStream.
		aStream space.
		right prettyPrintOn: aStream.
	] ifNil: [ 
		operation prettyPrintOn: aStream.
		aStream space.
		left prettyPrintOn: aStream.
	]


]

{ #category : #printing }
SAsmTacInstruction >> printOn: aStream [
	result ifNotNil: [ 
		result printOn: aStream.
		aStream nextPutAll: ' := '
	].
	
	right ifNotNil: [ 
		left printOn: aStream.
		aStream space.
		operation printOn: aStream.
		aStream space.
		right printOn: aStream.
	]


]

{ #category : #accessing }
SAsmTacInstruction >> result [
	^ result
]

{ #category : #accessing }
SAsmTacInstruction >> result: anObject [
	result := anObject
]

{ #category : #accessing }
SAsmTacInstruction >> right [
	^ right
]

{ #category : #accessing }
SAsmTacInstruction >> right: anObject [
	right := anObject
]

{ #category : #accessing }
SAsmTacInstruction >> value [
	^ left
]
