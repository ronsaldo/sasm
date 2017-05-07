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

{ #category : #'as yet unclassified' }
SAsmStreamElement >> computeMaximalSize [
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
SAsmStreamElement >> isCallInstruction [
	^ false
]

{ #category : #testing }
SAsmStreamElement >> isCondition [
	^ operation isCondition
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

{ #category : #'linear scan' }
SAsmStreamElement >> markVirtualRegisterLiveRanges [
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

{ #category : #accessing }
SAsmStreamElement >> size [
	self subclassResponsibility
]

{ #category : #writing }
SAsmStreamElement >> writeToStream: aStreamBuilder [
	aStreamBuilder add: self copy
]
