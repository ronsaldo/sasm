Class {
	#name : #SAsmInstruction,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'size',
		'template',
		'arguments',
		'argumentsHaveFixedSize',
		'selectedAlternative',
		'shortAlternative',
		'longAlternative',
		'longAlternativeSize',
		'shortAlternativeSize'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #visiting }
SAsmInstruction >> accept: aVisitor [
	^ aVisitor visitInstruction: self
]

{ #category : #accessing }
SAsmInstruction >> argumentCount [
	^ arguments size
]

{ #category : #accessing }
SAsmInstruction >> arguments [
	^ arguments
]

{ #category : #accessing }
SAsmInstruction >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
SAsmInstruction >> branchDestination [
	^ selectedAlternative branchDestinationOfInstruction: self
]

{ #category : #accessing }
SAsmInstruction >> computeBranchSpan [
	^ selectedAlternative branchSpanOfInstruction: self
]

{ #category : #'as yet unclassified' }
SAsmInstruction >> computeMaximalSize [
	size := template computeMaximalSizeFor: self
]

{ #category : #size }
SAsmInstruction >> computeShortAndLongAlternativesWith: aWriter [
	selectedAlternative := shortAlternative.
	shortAlternative == longAlternative ifTrue: [
		size := shortAlternativeSize := longAlternativeSize := shortAlternative computeSizeForInstruction: self with: aWriter
	] ifFalse: [
		size := shortAlternativeSize := shortAlternative computeSizeForInstruction: self with: aWriter.
		longAlternativeSize := longAlternative computeSizeForInstruction: self with: aWriter.
	]
]

{ #category : #accessing }
SAsmInstruction >> first [
	^ arguments first
]

{ #category : #printing }
SAsmInstruction >> fullPrintOn: aStream [
	aStream putKeyword: template name.
	arguments doWithIndex: [ :arg :index |
		index > 1 ifTrue: [ aStream nextPut: $, ].
		aStream space.
		arg prettyPrintOn: aStream
	]
]

{ #category : #testing }
SAsmInstruction >> hasDifferentAlternatives [
	^ shortAlternative ~~ longAlternative
]

{ #category : #testing }
SAsmInstruction >> hasFixedSize [
	^ false
]

{ #category : #accessing }
SAsmInstruction >> initialize [
	super initialize.
	size := 0.
	
]

{ #category : #testing }
SAsmInstruction >> isInstruction [
	^ true
]

{ #category : #testing }
SAsmInstruction >> isShortBranchSpan: aBranchSpan [
	^ shortAlternative isShortBranchSpan: aBranchSpan
]

{ #category : #accessing }
SAsmInstruction >> isValidShortSpan: span [
	^ shortAlternative isValidShortSpan: span
]

{ #category : #size }
SAsmInstruction >> longAlternativeSize [
	^ longAlternativeSize
]

{ #category : #'linear scan' }
SAsmInstruction >> markVirtualRegisterLiveAt: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex [
	arguments do: [ :arg | arg markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex]
]

{ #category : #accessing }
SAsmInstruction >> second [
	^ arguments second
]

{ #category : #'as yet unclassified' }
SAsmInstruction >> selectLongAlternative [
	selectedAlternative := longAlternative.
	size := longAlternativeSize
]

{ #category : #size }
SAsmInstruction >> shortAlternativeSize [
	^ shortAlternativeSize
]

{ #category : #accessing }
SAsmInstruction >> size [
	^ size
]

{ #category : #accessing }
SAsmInstruction >> size: anInteger [
	size := anInteger
]

{ #category : #accessing }
SAsmInstruction >> template [
	^ template
]

{ #category : #accessing }
SAsmInstruction >> template: anObject [
	template := anObject
]

{ #category : #accessing }
SAsmInstruction >> third [
	^ arguments third
]

{ #category : #'development support' }
SAsmInstruction >> validate [
	shortAlternative := template findBestShortAlternativeFor: self.
	longAlternative := template findBestLongAlternativeFor: self.

]

{ #category : #visiting }
SAsmInstruction >> writeBinaryWith: binaryWriter [
	^ selectedAlternative writeInstruction: self with: binaryWriter
]

{ #category : #'as yet unclassified' }
SAsmInstruction >> writeToStream: aStreamBuilder [
	aStreamBuilder add: (self copy arguments: (arguments collect: [:arg | arg copyWithStreamBuilder: aStreamBuilder]))
]
