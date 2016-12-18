Class {
	#name : #SAsmBinaryObjectWriter,
	#superclass : #Object,
	#instVars : [
		'sectionDictionary',
		'sectionList',
		'currentSection',
		'cpuMode',
		'symbolList',
		'symbolSet'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #'as yet unclassified' }
SAsmBinaryObjectWriter class >> writeStream: aStream [
	^ self new writeStream: aStream
]

{ #category : #initialization }
SAsmBinaryObjectWriter >> addSymbol: aSymbol [
	aSymbol shouldBeKeep ifFalse: [ ^ self ].
	
	(symbolSet includes: aSymbol) ifFalse: [
		symbolList add: aSymbol.
		symbolSet add: aSymbol.
	]
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
	symbolList := OrderedCollection new.
	symbolSet := Set new.
	
	aStream target setupBinaryObjectWriter: self.
	
	aStream do: [ :instruction |
		(currentSection isNil and: [ instruction isSection not ]) ifTrue: [ 
			currentSection := self createSectionNamed: #'..nil..'.
		].
	
		currentSection ifNotNil: [
			instruction
				position: currentSection size;
				section: currentSection.
		].
		
		instruction accept: self
	].
	
	sectionList do: [ :section | section data: section data contents ].
	^ SAsmBinaryObject new compilationTarget: aStream target; sections: sectionList asArray; symbols: symbolList asArray.
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

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> needsRelativeRelocation: immediate [
	| symbol |
	symbol := immediate symbol.
	symbol ifNil: [ ^ false ].
	symbol isUndefined ifTrue: [ ^ true ].
	symbol sectionName ~~ currentSection name ifTrue: [ ^ true ].
	^ symbol isPrivate not
]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> needsRelocation: immediate [
	^ immediate symbol isNotNil
]

{ #category : #accessing }
SAsmBinaryObjectWriter >> nextPut: aByte [
	currentSection data nextPut: aByte
]

{ #category : #accessing }
SAsmBinaryObjectWriter >> nextPutAll: aByteSequence [
	currentSection data nextPutAll: aByteSequence
]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutC16: anInteger [
	currentSection data
		nextPut: anInteger & 16rff;
		nextPut: (anInteger >> 8) & 16rff.
]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutC32: anInteger [
	currentSection data
		nextPut: anInteger & 16rff;
		nextPut: (anInteger >> 8) & 16rff;
		nextPut: (anInteger >> 16) & 16rff;
		nextPut: (anInteger >> 24) & 16rff
]

{ #category : #'byte writing' }
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

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutC8: anInteger [
	currentSection data nextPut: anInteger & 16rff
]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutI16: anImmediate [
	| value |
	(self needsRelocation: anImmediate) ifTrue: [ 
		self recordImmediateReloc16: anImmediate.
		self nextPutC16: 0
	] ifFalse: [ 
		value := anImmediate immediateValue.
		self nextPutC16: value
	]

]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutI32: anImmediate [
	| value |
	(self needsRelocation: anImmediate) ifTrue: [ 
		self recordImmediateReloc32: anImmediate.
		self nextPutC32: 0
	] ifFalse: [ 
		value := anImmediate immediateValue.
		self nextPutC32: value
	]

]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutI64: anImmediate [
	| value |
	(self needsRelocation: anImmediate) ifTrue: [ 
		self recordImmediateReloc64: anImmediate.
		self nextPutC64: 0
	] ifFalse: [ 
		value := anImmediate immediateValue.
		self nextPutC64: value
	]

]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutI8: anImmediate [
	| value |
	(self needsRelocation: anImmediate) ifTrue: [ 
		self recordImmediateReloc8: anImmediate.
		self nextPutC8: 0
	] ifFalse: [ 
		value := anImmediate immediateValue.
		self nextPutC8: value
	]

]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutIPRelative64: immediate extraOffset: extraOffset [
	| immediateValue |
	(self needsRelativeRelocation: immediate) ifTrue: [
		self recordImmediateRelativeReloc64: immediate extraAddend: extraOffset negated.
		self nextPutC64: 0.
	] ifFalse: [
		immediateValue := immediate immediateValueRelativeTo: currentSection position: currentSection size offset: extraOffset.
		self nextPutC64: immediateValue.
	]
]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutIPRelativeI16: immediate [
	self nextPutIPRelativeI16: immediate extraOffset: 2
]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutIPRelativeI16: immediate extraOffset: extraOffset [
	| immediateValue |
	(self needsRelativeRelocation: immediate) ifTrue: [
		self recordImmediateRelativeReloc16: immediate extraAddend: extraOffset negated.
		self nextPutC16: 0.
	] ifFalse: [
		immediateValue := immediate immediateValueRelativeTo: currentSection position: currentSection size offset: extraOffset.
		self nextPutC16: immediateValue.
	]
]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutIPRelativeI32: immediate [
	self nextPutIPRelativeI32: immediate extraOffset: 4
]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutIPRelativeI32: immediate extraOffset: extraOffset [
	| immediateValue |
	(self needsRelativeRelocation: immediate) ifTrue: [
		self recordImmediateRelativeReloc32: immediate extraAddend: extraOffset negated.
		self nextPutC32: 0.
	] ifFalse: [
		immediateValue := immediate immediateValueRelativeTo: currentSection position: currentSection size offset: extraOffset.
		self nextPutC32: immediateValue.
	]
]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutIPRelativeI8: immediate [
	self nextPutIPRelativeI8: immediate extraOffset: 1
]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutIPRelativeI8: immediate extraOffset: extraOffset [
	| immediateValue |
	(self needsRelativeRelocation: immediate) ifTrue: [
		self recordImmediateRelativeReloc8: immediate extraAddend: extraOffset negated.
		self nextPutC8: 0.
	] ifFalse: [
		immediateValue := immediate immediateValueRelativeTo: currentSection position: currentSection size offset: extraOffset.
		self nextPutC8: immediateValue.
	]
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateRelativeReloc16: immediate extraAddend: extraAddend [
	^ (self recordImmediateRelativeReloc: immediate extraAddend: extraAddend)
		relativeSOffset16;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateRelativeReloc32: immediate extraAddend: extraAddend [
	^ (self recordImmediateRelativeReloc: immediate extraAddend: extraAddend)
		relativeSOffset32;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateRelativeReloc64: immediate extraAddend: extraAddend [
	^ (self recordImmediateRelativeReloc: immediate extraAddend: extraAddend)
		relativeSOffset64;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateRelativeReloc8: immediate extraAddend: extraAddend [
	^ (self recordImmediateRelativeReloc: immediate extraAddend: extraAddend)
		relativeSOffset8;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateRelativeReloc: immediate extraAddend: extraAddend [
	| symbol reloc |
	symbol := immediate symbol.
	self assert: symbol isNotNil.
	
	reloc := SAsmBinaryObjectSectionRelocation new
		offset: currentSection size;
		addend: immediate addend + extraAddend;
		yourself.
	symbol shouldBeKeep ifTrue: [
		reloc symbol: symbol.
		self addSymbol: symbol.
	] ifFalse: [
		self assert: symbol isUndefined not.
		self assert: symbol section isNotNil.
		reloc addend: reloc addend + symbol value.
		reloc section: (self createSectionNamed: symbol sectionName)
	].

	currentSection addRelocation: reloc.
	^ reloc

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
	self addSymbol: aLabel symbol.
	aLabel symbol
		section: currentSection;
		value: aLabel position;
		yourself.
]

{ #category : #visiting }
SAsmBinaryObjectWriter >> visitSection: aSection [
	currentSection := self createSectionNamed: aSection name attributes: [:attr |
		self flag: 'Copy the section attributes.'
	].
	aSection
		position: currentSection size;
		section: aSection name.
	
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
