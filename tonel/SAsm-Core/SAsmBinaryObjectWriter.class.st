Class {
	#name : #SAsmBinaryObjectWriter,
	#superclass : #Object,
	#instVars : [
		'sectionDictionary',
		'sectionList',
		'currentSection'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #'as yet unclassified' }
SAsmBinaryObjectWriter class >> writeStream: aStream [
	^ self new writeStream: aStream
]

{ #category : #generation }
SAsmBinaryObjectWriter >> computeInitialPositionEstimate: aStream [
	| sectionSizes sectionName sectionSize |
	sectionSizes := IdentityDictionary new.
	sectionName := #'..nil..'.
	sectionSize := 0.
	
	aStream do: [ :element |
		element isSection ifTrue: [ 
			sectionSize ~= 0 ifTrue: [ 
				sectionSizes at: sectionName put: sectionSize 
			].
			sectionName := element name.
			sectionSize := 0.
		] ifFalse: [ 
			element position: sectionSize.
			element computeMaximalSize.
			sectionSize := sectionSize + element size
		].
	]
]

{ #category : #generation }
SAsmBinaryObjectWriter >> createSectionNamed: name [
	^ self createSectionNamed: name attributes: [ :section | ]
]

{ #category : #generation }
SAsmBinaryObjectWriter >> createSectionNamed: name attributes: aBlock [
	| result |
	^ sectionDictionary at: name ifAbsentPut: [
		result := SAsmBinaryObjectSection new
			name: name;
			data: (WriteStream on: (ByteArray new:128));
			yourself.
		aBlock value: result.
		sectionList add: result.
		result
	]
]

{ #category : #generation }
SAsmBinaryObjectWriter >> generateStream: aStream [
	sectionDictionary := Dictionary new.
	sectionList := OrderedCollection new.
	
	aStream do: [ :instruction |
		(currentSection isNil and: [ instruction isSection not ]) ifTrue: [ 
			currentSection := self createSectionNamed: #'..nil..'.
		].
	
		currentSection ifNotNil: [
			instruction position: currentSection size.
		].
		
		instruction accept: self
	].
	
	sectionList do: [ :section | section data: section data contents ].
	^ SAsmBinaryObject new sections: sectionList asArray.
]

{ #category : #generation }
SAsmBinaryObjectWriter >> generateUntilConvergence: aStream [
	| oldResult newResult |
	oldResult := 1.
	newResult := nil.
	[ newResult ~= oldResult ] whileTrue: [ 
		oldResult := newResult.
		newResult := self generateStream: aStream.
	].

	^ newResult
]

{ #category : #initialization }
SAsmBinaryObjectWriter >> initialize [
	super initialize.
]

{ #category : #accessing }
SAsmBinaryObjectWriter >> nextPut: aByte [
	currentSection data nextPut: aByte
]

{ #category : #visiting }
SAsmBinaryObjectWriter >> visitConstantExpressionValue: aConstantExpressionValue [
	| value |
	value := aConstantExpressionValue value evaluate.
	value writeWithSize: aConstantExpressionValue size on: self.
	self assert: currentSection size = (aConstantExpressionValue position + aConstantExpressionValue size)
]

{ #category : #visiting }
SAsmBinaryObjectWriter >> visitLabel: aLabel [
	aLabel symbol
		section: currentSection;
		value: aLabel position;
		yourself
]

{ #category : #visiting }
SAsmBinaryObjectWriter >> visitSection: aSection [
	currentSection := self createSectionNamed: aSection name attributes: [:attr |
		self flag: 'Copy the section attributes.'
	].
	aSection position: currentSection size.
	
]

{ #category : #writing }
SAsmBinaryObjectWriter >> writeStream: aStream [
	^ self writeStreamInstructions: aStream.
]

{ #category : #writing }
SAsmBinaryObjectWriter >> writeStreamInstructions: aStream [
	self computeInitialPositionEstimate: aStream.
	^ self generateUntilConvergence: aStream
]
