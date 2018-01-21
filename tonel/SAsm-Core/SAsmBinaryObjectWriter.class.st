"
I am a generic two pass assembler.

For selecting between short and long forms of branch instructions, I use the  algorithm in the following paper:

Thomas G. Szymanski. 1978. Assembling code for machines with span-dependent instructions. Commun. ACM 21, 4 (April 1978), 300-308. DOI=http://dx.doi.org/10.1145/359460.359474
"
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
		'compilationTarget',
		'debugSourceLocationsList',
		'dummyWriter',
		'labelInstructions',
		'shortLongBranches',
		'labelInstructionDictionary'
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

{ #category : #'two pass assembler' }
SAsmBinaryObjectWriter >> buildBranchDependencies: branch [
	| destination label |
	(self hasToBeALongBranch: branch) ifTrue: [ ^ self ].
	
	destination := branch destination.
	self assert: destination isImmediateSymbolWithAddend.
	label := labelInstructionDictionary at: destination symbol ifAbsent: [^ self ].
	
	branch span: branch instruction computeBranchSpan.
	branch index <= label shortLongBranchesPrecedingCount ifTrue: [ 
		"Forward branch"
		branch index + 1 to: label shortLongBranchesPrecedingCount do: [ :depIndex |
			branch addDependency: (shortLongBranches at: depIndex)
		]. 
	] ifFalse: [
		"Backward branch"
		label shortLongBranchesPrecedingCount to: branch index - 1 do: [ :depIndex |
			branch addDependency: (shortLongBranches at: depIndex)
		]. 
	].

]

{ #category : #'two pass assembler' }
SAsmBinaryObjectWriter >> buildShortLongBranchDependencyGraph [
	shortLongBranches do: [ :branch |
		self buildBranchDependencies: branch
	]
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> checkNonTextSectionForPIC [
	compilationTarget hasPositionIndependentCode ifFalse: [ ^ self ].
	currentSection executable ifTrue: [ self error: 'Adding invalid relocation for PIC code.' ]
]

{ #category : #'two pass assembler' }
SAsmBinaryObjectWriter >> computeStreamSizes: aStream [
	| sectionSize branchDestination |
	sectionSize := 0.
	aStream do: [ :element |
		element isSection ifTrue: [ 
			currentSection := sectionDictionary at: element name
		].
		element isLabel ifTrue: [
			element symbol section: currentSection.
			labelInstructions add: (SAsmBinaryObjectWriterLabel new
				label: element;
				shortLongBranchesPrecedingCount: shortLongBranches size).
			labelInstructionDictionary at: element symbol put: labelInstructions last
		].
	
		element section: currentSection;
			position: sectionSize.
		element computeShortAndLongAlternativesWith: self.
		element hasDifferentAlternatives ifTrue: [
			branchDestination := element branchDestination.
			branchDestination isImmediateSymbolWithAddend ifFalse: [
				element selectLongAlternative
			] ifTrue: [
				shortLongBranches add: (SAsmBinaryObjectWriterShortLongBranch new
					index: shortLongBranches size + 1;
					instruction: element;
					destination: branchDestination;
					yourself)
			].
		].
	
		sectionSize := sectionSize + element size
	].
]

{ #category : #'two pass assembler' }
SAsmBinaryObjectWriter >> computeStreamsSizes: aCollectionOfStreams [
	aCollectionOfStreams do: [ :stream |
		self computeStreamSizes: stream
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

{ #category : #accessing }
SAsmBinaryObjectWriter >> dummy [
	^ (dummyWriter ifNil: [ dummyWriter := SAsmBinaryObjectDummyWriter new target: self ]) reset
]

{ #category : #generation }
SAsmBinaryObjectWriter >> generateDebugLines [
	currentSection := sectionDictionary at: #'.debug_line' ifAbsent: [ ^ self ].
	self writeDWDebugLines.
]

{ #category : #'two pass assembler' }
SAsmBinaryObjectWriter >> generateInTwoPasses: aStream [
	| sectionStreams result |
	sectionStreams := aStream splitInSections.

	"Setup the generation of the streams"
	self setupStreams: sectionStreams.
	
	"First pass: compute sizes"
	self computeStreamsSizes: sectionStreams.
	
	"Optimize the stream sizes"
	self optimizeBranches: sectionStreams.
	
	"Second pass: generate streams."
	result := self generateStreams: sectionStreams.
	result concretizePendingSymbolWith: self.
	^ result
]

{ #category : #generation }
SAsmBinaryObjectWriter >> generateStream: aStream [
	| expectedNewSize |
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
		
		expectedNewSize := instruction position + instruction size.
		instruction accept: self.
		self assert: currentSection currentDataSize = expectedNewSize
	].

]

{ #category : #generation }
SAsmBinaryObjectWriter >> generateStreams: aCollectionOfStreams [
	aCollectionOfStreams do: [ :stream | self generateStream: stream].

	self postProcessStreamGeneration.
	
	sectionList do: [ :section |
		section size: section currentDataSize.
		section data: section data contents
	].
	^ SAsmBinaryObject new
		compilationTarget: compilationTarget;
		sections: sectionList asArray;
		symbols: symbolList asArray;
		sortSections
]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectWriter >> getSectionNamed: name [
	^ sectionDictionary at: name
]

{ #category : #'two pass assembler' }
SAsmBinaryObjectWriter >> hasToBeALongBranch: branch [
	branch destination symbol section ~~ branch instruction section ifTrue: [ ^ true ].
	^ false
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
	immediate isAtGOT ifTrue: [ ^ true ].
	
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
	anImmediate isInteger ifTrue: [ ^ self nextPutC32: anImmediate ].
	
	(self needsRelocation: anImmediate) ifTrue: [
		anImmediate isAtGOT ifTrue: [
			self recordImmediateRelativeReloc32AtGOT: anImmediate extraAddend: 0.
			^ self nextPutC32: 0.
		].
		anImmediate isRelativeGlobalOffsetTable ifTrue: [
			self recordImmediateRelativeReloc32GlobalOffsetTable: anImmediate extraAddend: 0.
			^ self nextPutC32: 0.
		].
		anImmediate isGOTOffset ifTrue: [
			self recordImmediateRelativeReloc32GOTOffset: anImmediate extraAddend: 0.
			^ self nextPutC32: 0.
		].
	
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
SAsmBinaryObjectWriter >> nextPutIPRelativeBranch32: immediate [
	self nextPutIPRelativeBranch32: immediate extraOffset: 4
]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutIPRelativeBranch32: immediate extraOffset: extraOffset [
	| immediateValue |
	(self needsRelativeRelocation: immediate) ifTrue: [
		self recordImmediateRelativeRelocBranch32: immediate extraAddend: extraOffset negated.
		self nextPutC32: 0.
	] ifFalse: [
		immediateValue := immediate immediateValueRelativeTo: currentSection position: currentSection currentDataSize offset: extraOffset.
		self nextPutC32: immediateValue.
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
		immediate isAtGOT ifTrue: [ 
			self recordImmediateRelativeReloc32AtGOT: immediate extraAddend: extraOffset negated.
			self nextPutC32: 0.
		] ifFalse: [ 
			self recordImmediateRelativeReloc32: immediate extraAddend: extraOffset negated.
			self nextPutC32: 0.
		].
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
	self assert: (self needsRelativeRelocation: immediate) not.
	immediateValue := immediate immediateValueRelativeTo: currentSection position: currentSection currentDataSize offset: extraOffset.
	self assert: (-128 <= immediateValue and: [immediateValue <= 127]).
	self nextPutC8: immediateValue.

]

{ #category : #'byte writing' }
SAsmBinaryObjectWriter >> nextPutZeros: size [
	currentSection nextPutZeros: size
]

{ #category : #'two pass assembler' }
SAsmBinaryObjectWriter >> optimizeBranches: sectionStreams [
	labelInstructions do: [ :l | l label applyPosition ].
	shortLongBranches ifEmpty: [ ^ self ].

	"Build the dependency graph."	
	self buildShortLongBranchDependencyGraph.
	self promoteImpossibleLongBranches.
	
	"At the end, recompute "	
	self recomputeStreamsAddresses: sectionStreams.
	labelInstructions do: [ :l | l label applyPosition ].

]

{ #category : #generation }
SAsmBinaryObjectWriter >> postProcessStreamGeneration [
	self generateDebugLines
]

{ #category : #'two pass assembler' }
SAsmBinaryObjectWriter >> promoteImpossibleLongBranches [
	| pendingElements branch |
	pendingElements := IdentitySet new.
	pendingElements addAll: shortLongBranches.
	
	[ pendingElements isNotEmpty ] whileTrue: [
		branch := pendingElements anyOne.
		pendingElements remove: branch.
		
		((self hasToBeALongBranch: branch) or: [ branch hasShortSpan not ]) ifTrue: [
			branch promoteToLongBranch.
			branch parents do: [ :parent |
				parent promotedToLong ifFalse: [ 
					pendingElements add: parent
				].
			].	
		].
	].

]

{ #category : #'two pass assembler' }
SAsmBinaryObjectWriter >> recomputeStreamAddresses: aStream [
	| sectionSize |
	sectionSize := 0.
	aStream do: [ :element |
		element position: sectionSize.
		sectionSize := sectionSize + element size
	].

]

{ #category : #'two pass assembler' }
SAsmBinaryObjectWriter >> recomputeStreamsAddresses: aCollectionOfStreams [
	aCollectionOfStreams do: [ :stream |
		self recomputeStreamAddresses: stream
	]
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
SAsmBinaryObjectWriter >> recordImmediateRelativeReloc32AtGOT: immediate extraAddend: extraAddend [
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		relativeSOffset32AtGOT;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateRelativeReloc32GOTOffset: immediate extraAddend: extraAddend [
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		relativeSOffset32GOTOffset;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateRelativeReloc32GlobalOffsetTable: immediate extraAddend: extraAddend [
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		relativeSOffset32GlobalOffsetTable;
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
SAsmBinaryObjectWriter >> recordImmediateRelativeRelocBranch32: immediate extraAddend: extraAddend [
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		relativeBranch32;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateReloc16: immediate extraAddend: extraAddend [
	self checkNonTextSectionForPIC.
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		absoluteOffset16;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateReloc32: immediate extraAddend: extraAddend [
	self checkNonTextSectionForPIC.
	immediate sectionRelative ifTrue: [ 
		^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
			sectionRelativeOffset32;
			yourself
	].
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		absoluteOffset32;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateReloc64: immediate extraAddend: extraAddend [
	self checkNonTextSectionForPIC.
	immediate sectionRelative ifTrue: [ 
		^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
			sectionRelativeOffset64;
			yourself
	].
	^ (self recordImmediateReloc: immediate extraAddend: extraAddend)
		absoluteOffset64;
		yourself
]

{ #category : #relocations }
SAsmBinaryObjectWriter >> recordImmediateReloc8: immediate extraAddend: extraAddend [
	self checkNonTextSectionForPIC.
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
		reloc pendingSymbol: symbol.
	].

	currentSection addRelocation: reloc.
	^ reloc

]

{ #category : #generation }
SAsmBinaryObjectWriter >> setupStreams: aCollectionOfStreams [
	sectionDictionary := Dictionary new.
	sectionList := OrderedCollection new.
	symbolList := OrderedCollection new.
	symbolSet := Set new.
	debugSourceLocationsList := OrderedCollection new.
	labelInstructions := OrderedCollection new.
	labelInstructionDictionary := IdentityDictionary new.
	shortLongBranches := OrderedCollection new.
	
	aCollectionOfStreams first target setupBinaryObjectWriter: self.

	"Create the sections."
	currentSection := nil.	
	aCollectionOfStreams do: [ :stream | 
		self assert: stream first isSection.
		stream first accept: self.
	].

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
	alignInstruction isCodeAlignment ifTrue: [ 
		compilationTarget emitNopOfSize: paddingSize with: self
	] ifFalse: [ 
		self nextPutZeros: paddingSize.
	].

	self assert: (currentSection currentDataSize % alignment) = 0
	
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
	anInstruction writeBinaryWith: self.

]

{ #category : #visiting }
SAsmBinaryObjectWriter >> visitLabel: aLabel [
	self assert: aLabel symbol value == aLabel position.
	self assert: aLabel symbol section == currentSection.
	self addSymbol: aLabel symbol
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
	| result |
	result := self generateInTwoPasses: aStream.
	result validateRelocations.
	^ result

]
