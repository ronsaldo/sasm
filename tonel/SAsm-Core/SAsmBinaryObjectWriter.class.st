Class {
	#name : #SAsmBinaryObjectWriter,
	#superclass : #Object,
	#instVars : [
		'sectionDictionary',
		'sectionList',
		'currentSection',
		'cpuMode'
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

{ #category : #accessing }
SAsmBinaryObjectWriter >> cpuMode [
	^ cpuMode
]

{ #category : #accessing }
SAsmBinaryObjectWriter >> cpuMode: anObject [
	cpuMode := anObject
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
	cpuMode := #normal.
]

{ #category : #testing }
SAsmBinaryObjectWriter >> isLongMode [
	^ cpuMode == #long
]

{ #category : #testing }
SAsmBinaryObjectWriter >> isShortMode [
	^ cpuMode == #short
]

{ #category : #accessing }
SAsmBinaryObjectWriter >> nextPut: aByte [
	currentSection data nextPut: aByte
]

{ #category : #accessing }
SAsmBinaryObjectWriter >> nextPutAll: aByteSequence [
	currentSection data nextPutAll: aByteSequence
]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectWriter >> nextPutC16: anInteger [
	currentSection data
		nextPut: anInteger & 16rff;
		nextPut: (anInteger >> 8) & 16rff.
]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectWriter >> nextPutC32: anInteger [
	currentSection data
		nextPut: anInteger & 16rff;
		nextPut: (anInteger >> 8) & 16rff;
		nextPut: (anInteger >> 16) & 16rff;
		nextPut: (anInteger >> 24) & 16rff
]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectWriter >> nextPutC64: anInteger [
	currentSection data
		nextPut: anInteger & 16rff;
		nextPut: (anInteger >> 8) & 16rff;
		nextPut: (anInteger >> 16) & 16rff;
		nextPut: (anInteger >> 24) & 16rff;
		nextPut: (anInteger >> 32) & 16rff;
		nextPut: (anInteger >> 40) & 16rff;
		nextPut: (anInteger >> 48) & 16rff;
		nextPut: (anInteger >> 56) & 16rff
]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectWriter >> nextPutC8: anInteger [
	currentSection data nextPut: anInteger & 16rff
]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectWriter >> nextPutI16: anImmediate [
	| value |
	value := anImmediate immediateValue.
	self nextPutC16: value
]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectWriter >> nextPutI32: anImmediate [
	| value |
	value := anImmediate immediateValue.
	self nextPutC32: value
]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectWriter >> nextPutI64: anImmediate [
	| value |
	value := anImmediate immediateValue.
	self nextPutC64: value
]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectWriter >> nextPutI8: anImmediate [
	| value |
	value := anImmediate immediateValue.
	self nextPutC8: value
]

{ #category : #visiting }
SAsmBinaryObjectWriter >> visitConstantExpressionValue: aConstantExpressionValue [
	| value |
	value := aConstantExpressionValue value evaluate.
	value writeWithSize: aConstantExpressionValue size on: self.
	self assert: currentSection size = (aConstantExpressionValue position + aConstantExpressionValue size)
]

{ #category : #visiting }
SAsmBinaryObjectWriter >> visitInstruction: anInstruction [
	anInstruction template writeInstruction: anInstruction with: self
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
