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

{ #category : #'linear scan' }
SAsmTacInstruction >> markVirtualRegisterLiveAt: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex [
	result ifNotNil: [ result markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex].
	left ifNotNil: [ left markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex].
	right ifNotNil: [ right markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex].

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
		operation prettyPrintOn: aStream.
		aStream space.
		left prettyPrintOn: aStream.
		aStream space.
		right prettyPrintOn: aStream.
	] ifNil: [ 
		operation prettyPrintOn: aStream.
		left ifNotNil: [ 
			aStream space.
			left prettyPrintOn: aStream.
		]
	]


]

{ #category : #printing }
SAsmTacInstruction >> printOn: aStream [
	result ifNotNil: [ 
		result printOn: aStream.
		aStream nextPutAll: ' := '
	].
	
	right ifNotNil: [ 
		operation printOn: aStream.
		aStream space.
		left printOn: aStream.
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
