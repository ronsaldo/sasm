Class {
	#name : #SAsmInstruction,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'size',
		'template',
		'arguments',
		'bestTemplateAlternative',
		'argumentsHaveFixedSize'
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
SAsmInstruction >> argumentsHaveFixedSize [
	argumentsHaveFixedSize ifNotNil: [ ^ argumentsHaveFixedSize ].
	arguments do: [ :arg |
		arg hasFixedSize ifFalse: [ ^ argumentsHaveFixedSize := false ]
	].

	^ argumentsHaveFixedSize := true
]

{ #category : #accessing }
SAsmInstruction >> bestTemplateAlternative [
	^ bestTemplateAlternative
]

{ #category : #accessing }
SAsmInstruction >> bestTemplateAlternative: anObject [
	bestTemplateAlternative := anObject
]

{ #category : #'as yet unclassified' }
SAsmInstruction >> computeMaximalSize [
	size := template computeMaximalSizeFor: self
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

{ #category : #'linear scan' }
SAsmInstruction >> markVirtualRegisterLiveAt: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex [
	arguments do: [ :arg | arg markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex]
]

{ #category : #accessing }
SAsmInstruction >> second [
	^ arguments second
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

{ #category : #'as yet unclassified' }
SAsmInstruction >> writeToStream: aStreamBuilder [
	aStreamBuilder add: (self copy arguments: (arguments collect: [:arg | arg copyWithStreamBuilder: aStreamBuilder]))
]
