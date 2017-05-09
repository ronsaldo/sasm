Class {
	#name : #SAsmTacBranchInstruction,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'condition',
		'trueDestination',
		'falseDestination'
	],
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacBranchInstruction >> accept: aVisitor [
	^ aVisitor visitTacBranchInstruction: self
]

{ #category : #accessing }
SAsmTacBranchInstruction >> condition [
	^ condition
]

{ #category : #accessing }
SAsmTacBranchInstruction >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
SAsmTacBranchInstruction >> falseDestination [
	^ falseDestination
]

{ #category : #accessing }
SAsmTacBranchInstruction >> falseDestination: anObject [
	falseDestination := anObject
]

{ #category : #testing }
SAsmTacBranchInstruction >> isConditionalJump [
	^ true
]

{ #category : #testing }
SAsmTacBranchInstruction >> isThreeAddressInstruction [
	^ true
]

{ #category : #accessing }
SAsmTacBranchInstruction >> markVirtualRegisterLiveAt: livePosition [
	condition ifNotNil: [ condition markVirtualRegisterLiveRangePosition: livePosition ].
]

{ #category : #'as yet unclassified' }
SAsmTacBranchInstruction >> prettyPrintOn: aStream [
	aStream putKeyword: #branch; space.
	condition prettyPrintOn: aStream.
	aStream space.
	trueDestination prettyPrintOn: aStream.
	aStream space.
	falseDestination prettyPrintOn: aStream.
	aStream space.

]

{ #category : #'as yet unclassified' }
SAsmTacBranchInstruction >> printOn: aStream [
	aStream nextPutAll: #branch; space.
	condition printOn: aStream.
	aStream space.
	trueDestination printOn: aStream.
	aStream space.
	falseDestination printOn: aStream.
	aStream space.

]

{ #category : #accessing }
SAsmTacBranchInstruction >> trueDestination [
	^ trueDestination
]

{ #category : #accessing }
SAsmTacBranchInstruction >> trueDestination: anObject [
	trueDestination := anObject
]
