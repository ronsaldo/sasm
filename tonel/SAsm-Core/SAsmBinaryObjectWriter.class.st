Class {
	#name : #SAsmBinaryObjectWriter,
	#superclass : #Object,
	#instVars : [
		'sectionDictionary',
		'sectionList',
		'currentSection',
		'cpuMode',
		'symbolList',
		'symbolSet',
		'pendingLocalSymbolRelocations',
		'compilationTarget',
		'debugSourceLocationsList'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #'as yet unclassified' }
SAsmBinaryObjectWriter class >> target: aCompilationTarget writeStream: aStream [
	^ self new target: aCompilationTarget; writeStream: aStream
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> addRelocationAt: offset toSection: targetSection addend: addend [
	| reloc |
	reloc := SAsmBinaryObjectSectionRelocation new
		offset: offset;
		addend: addend;
		section: targetSection;
		yourself.
	currentSection addRelocation: reloc.
	^ reloc
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
	^ self createSectionNamed: name loaded: true attributes: aBlock
]

{ #category : #generation }
SAsmBinaryObjectWriter >> createSectionNamed: name loaded: isLoaded attributes: aBlock [
	| result |
	result := sectionDictionary at: name ifAbsentPut: [
		result := SAsmBinaryObjectSection new
			name: name;
			data: (isLoaded ifTrue: [WriteStream on: (ByteArray new:128)] ifFalse: [SAsmByteNullStream new]);
			yourself.
		sectionList add: result.
	].

	aBlock value: result.
	^ result
]

{ #category : #accessing }
SAsmBinaryObjectWriter >> currentSectionPosition [
	^ currentSection data position
]

{ #category : #generation }
SAsmBinaryObjectWriter >> generateDebugLines [
	currentSection := sectionDictionary at: #'.debug_line' ifAbsent: [ ^ self ].
	self writeDWDebugLines.
]

{ #category : #generation }
SAsmBinaryObjectWriter >> generateStream: aStream [
	sectionDictionary := Dictionary new.
	sectionList := OrderedCollection new.
	symbolList := OrderedCollection new.
	symbolSet := Set new.
	debugSourceLocationsList := OrderedCollection new.
	
	aStream target setupBinaryObjectWriter: self.
	
	currentSection := nil.
	aStream do: [ :instruction |
		(currentSection isNil and: [ instruction isSection not ]) ifTrue: [ 
			currentSection := self createSectionNamed: #'..nil..'.
		].
	
		currentSection ifNotNil: [
			instruction
				position: currentSection currentDataSize;
				section: currentSection.
		].
		
		instruction accept: self
	].

	self postProcessStreamGeneration.
	
	sectionList do: [ :section |
		section size: section currentDataSize.
		section data: section data contents
	].
	pendingLocalSymbolRelocations ifNotEmpty: [ self error: 'Undefined local symbols' ].
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
	pendingLocalSymbolRelocations := IdentityDictionary new.
]

{ #category : #testing }
SAsmBinaryObjectWriter >> isLongMode [
	^ cpuMode == #long
]

{ #category : #testing }
SAsmBinaryObjectWriter >> isShortMode [
	^ cpuMode == #short
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> localSymbol: symbol buildRelocation: relocationBlock [
	symbol isUndefined ifFalse: [ 
		^ relocationBlock value
	].

	(pendingLocalSymbolRelocations at: symbol ifAbsentPut: [ OrderedCollection new ])
		add: relocationBlock
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
		self recordImmediateReloc16: anImmediate extraAddend: 0.
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
		self recordImmediateReloc32: anImmediate extraAddend: 0.
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
		self recordImmediateReloc64: anImmediate extraAddend: 0.
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
		self recordImmediateReloc8: anImmediate extraAddend: 0.
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
		immediateValue := immediate immediateValueRelativeTo: currentSection position: currentSection currentDataSize offset: extraOffset.
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
		immediateValue := immediate immediateValueRelativeTo: currentSection position: currentSection currentDataSize offset: extraOffset.
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
		immediateValue := immediate immediateValueRelativeTo: currentSection position: currentSection currentDataSize offset: extraOffset.
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
		immediateValue := immediate immediateValueRelativeTo: currentSection position: currentSection currentDataSize offset: extraOffset.
		self nextPutC8: immediateValue.
	]
]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutZeros: size [
	currentSection nextPutZeros: size
]

{ #category : #generation }
SAsmBinaryObjectWriter >> postProcessStreamGeneration [
	self generateDebugLines
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateRelativeReloc16: immediate extraAddend: extraAddend [
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		relativeSOffset16;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateRelativeReloc32: immediate extraAddend: extraAddend [
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		relativeSOffset32;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateRelativeReloc64: immediate extraAddend: extraAddend [
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		relativeSOffset64;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateRelativeReloc8: immediate extraAddend: extraAddend [
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		relativeSOffset8;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateReloc16: immediate extraAddend: extraAddend [
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		absoluteOffset16;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateReloc32: immediate extraAddend: extraAddend [
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		absoluteOffset32;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateReloc64: immediate extraAddend: extraAddend [
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		absoluteOffset64;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateReloc8: immediate extraAddend: extraAddend [
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		absoluteOffset8;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateReloc: immediate extraAddend: extraAddend [
	| symbol reloc |
	symbol := immediate symbol.
	self assert: symbol isNotNil.
	
	reloc := SAsmBinaryObjectSectionRelocation new
		offset: currentSection currentDataSize;
		addend: immediate addend + extraAddend;
		yourself.
	symbol shouldBeKeep ifTrue: [
		reloc symbol: symbol.
		self addSymbol: symbol.
	] ifFalse: [
		self localSymbol: symbol buildRelocation: [ 
			self assert: symbol isUndefined not.
			self assert: symbol section isNotNil.
			reloc addend: reloc addend + symbol value.
			reloc section: (self createSectionNamed: symbol sectionName)
		]
	].

	currentSection addRelocation: reloc.
	^ reloc

]

{ #category : #accessing }
SAsmBinaryObjectWriter >> target [
	^ compilationTarget
]

{ #category : #accessing }
SAsmBinaryObjectWriter >> target: aCompilationTarget [
	compilationTarget := aCompilationTarget
]

{ #category : #visiting }
SAsmBinaryObjectWriter >> visitAlignInstruction: alignInstruction [
	| alignment paddingSize |
	alignment := alignInstruction alignment.
	currentSection alignment: (currentSection alignment max: alignment).
	paddingSize := alignInstruction size.
	self nextPutZeros: paddingSize.
]

{ #category : #visiting }
SAsmBinaryObjectWriter >> visitConstantExpressionValue: aConstantExpressionValue [
	| value |
	value := aConstantExpressionValue value evaluate.
	value writeWithSize: aConstantExpressionValue size on: self.
	self assert: currentSection currentDataSize = (aConstantExpressionValue position + aConstantExpressionValue size)
]

{ #category : #visiting }
SAsmBinaryObjectWriter >> visitConstantZeros: zeros [
	self nextPutZeros: zeros size
]

{ #category : #visiting }
SAsmBinaryObjectWriter >> visitDebugSourceLocation: aDebugLocation [
	debugSourceLocationsList add: aDebugLocation
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
	pendingLocalSymbolRelocations at: aLabel symbol ifPresent: [ :pendingRelocations |
		pendingRelocations do: #value.
		pendingLocalSymbolRelocations removeKey: aLabel symbol
	]
]

{ #category : #visiting }
SAsmBinaryObjectWriter >> visitLabelEnd: aLabelEnd [
	aLabelEnd symbol
		size: aLabelEnd position - aLabelEnd symbol value
]

{ #category : #visiting }
SAsmBinaryObjectWriter >> visitSection: aSection [
	currentSection := self createSectionNamed: aSection name loaded: aSection loaded attributes: [:attr |
		attr loaded: aSection loaded.
		attr executable: aSection executable.
		attr readable: aSection readable.
		attr writeable: aSection writeable.
		attr debugging: aSection debugging.
	].

	aSection
		position: currentSection currentDataSize;
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
