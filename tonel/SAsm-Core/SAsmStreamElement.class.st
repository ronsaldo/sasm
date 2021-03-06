Class {
	#name : #SAsmStreamElement,
	#superclass : #SAsmObject,
	#instVars : [
		'next',
		'previous',
		'position',
		'section',
		'index'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #visiting }
SAsmStreamElement >> accept: aVisitor [
	self subclassResponsibility
]

{ #category : #converting }
SAsmStreamElement >> asSAsmStreamElement [
	^ self
]

{ #category : #successors }
SAsmStreamElement >> blockSuccessorsDo: aBlock [
]

{ #category : #accessing }
SAsmStreamElement >> childrenNodes [
	^ #()
]

{ #category : #size }
SAsmStreamElement >> computeShortAndLongAlternativesWith: aWriter [
]

{ #category : #testing }
SAsmStreamElement >> hasDifferentAlternatives [
	^ false
]

{ #category : #testing }
SAsmStreamElement >> hasFixedSize [
	^ false
]

{ #category : #accessing }
SAsmStreamElement >> index [
	^ index
]

{ #category : #accessing }
SAsmStreamElement >> index: anObject [
	index := anObject
]

{ #category : #initialization }
SAsmStreamElement >> initialize [
	super initialize.
	position := 0.
	
]

{ #category : #testing }
SAsmStreamElement >> isAlignInstruction [
	^ false
]

{ #category : #testing }
SAsmStreamElement >> isCallInstruction [
	^ false
]

{ #category : #testing }
SAsmStreamElement >> isCondition [
	^ false
]

{ #category : #testing }
SAsmStreamElement >> isConditionalJump [
	^ false
]

{ #category : #testing }
SAsmStreamElement >> isConstantExpressionValue [
	^ false
]

{ #category : #testing }
SAsmStreamElement >> isConstantZeros [
	^ false
]

{ #category : #testing }
SAsmStreamElement >> isDebugInstruction [
	^ false
]

{ #category : #testing }
SAsmStreamElement >> isInstruction [
	^ false
]

{ #category : #testing }
SAsmStreamElement >> isLabel [
	^ false
]

{ #category : #testing }
SAsmStreamElement >> isSection [
	^ false
]

{ #category : #testing }
SAsmStreamElement >> isThreeAddressInstruction [
	^ false
]

{ #category : #size }
SAsmStreamElement >> longAlternativeSize [
	^ self size
]

{ #category : #'linear scan' }
SAsmStreamElement >> markVirtualRegisterLiveAt: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex [
]

{ #category : #testing }
SAsmStreamElement >> needsToSpillWith: instructionLowerer [
	^ false
]

{ #category : #accessing }
SAsmStreamElement >> next [
	^ next
]

{ #category : #accessing }
SAsmStreamElement >> next: anObject [
	next := anObject
]

{ #category : #accessing }
SAsmStreamElement >> nodeTitle [
	^ self fullPrintString
]

{ #category : #accessing }
SAsmStreamElement >> nonDebugNext [
	| currentNode |
	currentNode := self next.
	[currentNode isNotNil and: [ currentNode isDebugInstruction ]] whileTrue: [ 
		currentNode := currentNode next
	].
	^ currentNode
]

{ #category : #accessing }
SAsmStreamElement >> position [
	^ position
]

{ #category : #accessing }
SAsmStreamElement >> position: anInteger [
	position := anInteger
]

{ #category : #copying }
SAsmStreamElement >> postCopy [
	previous := nil.
	next := nil.
]

{ #category : #writing }
SAsmStreamElement >> prepareWriteToStream: aStreamBuilder [
]

{ #category : #accessing }
SAsmStreamElement >> previous [
	^ previous
]

{ #category : #accessing }
SAsmStreamElement >> previous: anObject [
	previous := anObject
]

{ #category : #accessing }
SAsmStreamElement >> section [
	^ section
]

{ #category : #accessing }
SAsmStreamElement >> section: anObject [
	section := anObject
]

{ #category : #accessing }
SAsmStreamElement >> sectionName [
	^ section ifNotNil: [ section name ]
]

{ #category : #size }
SAsmStreamElement >> shortAlternativeSize [
	^ self size
]

{ #category : #accessing }
SAsmStreamElement >> size [
	self subclassResponsibility
]

{ #category : #writing }
SAsmStreamElement >> writeToStream: aStreamBuilder [
	aStreamBuilder add: self copy
]
