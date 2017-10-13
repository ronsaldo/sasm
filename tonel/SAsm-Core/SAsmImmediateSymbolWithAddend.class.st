Class {
	#name : #SAsmImmediateSymbolWithAddend,
	#superclass : #SAsmImmediate,
	#instVars : [
		'size',
		'symbol',
		'addend',
		'relocationKind'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #arithmetic }
SAsmImmediateSymbolWithAddend >> + constant [
	self assert: constant isInteger.
	^ self copy addend: addend + constant
]

{ #category : #arithmetic }
SAsmImmediateSymbolWithAddend >> - constant [
	self assert: constant isInteger.
	^ self copy addend: addend - constant
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> addend [
	^ addend
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> addend: anObject [
	addend := anObject
]

{ #category : #converting }
SAsmImmediateSymbolWithAddend >> asGOTReference [
	^ self copy addend: 0; makeGOT
]

{ #category : #converting }
SAsmImmediateSymbolWithAddend >> asSAsmConstantExpression [
	^ SAsmConstantExpressionSymbolValue new size: self size; symbol: self 
]

{ #category : #converting }
SAsmImmediateSymbolWithAddend >> asSAsmStreamElement [
	^ self asSAsmConstantExpression asSAsmStreamElement
]

{ #category : #converting }
SAsmImmediateSymbolWithAddend >> asX86PointerOfSize: pointerSize withBuilder: streamBuilder [
	^ SAsmX86RegisterAddress new size: pointerSize; displacement: (self copyWithStreamBuilder: streamBuilder)
]

{ #category : #'as yet unclassified' }
SAsmImmediateSymbolWithAddend >> copyWithStreamBuilder: streamBuilder [
	^ self copy symbol: (streamBuilder findSymbolForObject: symbol)
]

{ #category : #testing }
SAsmImmediateSymbolWithAddend >> hasFixedSize [
	^ false
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> immediateValue [
	^ 0
]

{ #category : #'as yet unclassified' }
SAsmImmediateSymbolWithAddend >> immediateValueRelativeTo: section position: immediateWritePosition offset: relativeCheckOffset [
	section name ~~ symbol sectionName ifTrue: [
		^ relativeCheckOffset negated.
	].

	^ symbol value - (immediateWritePosition + relativeCheckOffset)
]

{ #category : #initialization }
SAsmImmediateSymbolWithAddend >> initialize [
	super initialize.
	addend := 0.
	sectionRelative := false.
]

{ #category : #testing }
SAsmImmediateSymbolWithAddend >> isAtGOT [
	^ relocationKind == #got
]

{ #category : #testing }
SAsmImmediateSymbolWithAddend >> isGOTOffset [
	^ relocationKind == #'got-offset'
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> isImmediate16 [
	^ size = 2
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> isImmediate32 [
	^ size = 4
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> isImmediate64 [
	^ size = 8
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> isImmediate8 [
	^ size = 1
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> isImmediateS16 [
	^ self isImmediate16
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> isImmediateS32 [
	^ self isImmediate32
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> isImmediateS64 [
	^ self isImmediate64
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> isImmediateS8 [
	^ self isImmediate8
]

{ #category : #'as yet unclassified' }
SAsmImmediateSymbolWithAddend >> isImmediateS8RelativeTo: anInstruction position: immediateWritePosition offset: relativeCheck [
	(anInstruction sectionName ~= symbol sectionName) ifTrue: [ ^ false ].
	^ super isImmediateS8RelativeTo: anInstruction position: immediateWritePosition offset: relativeCheck
]

{ #category : #testing }
SAsmImmediateSymbolWithAddend >> isImmediateSymbolWithAddend [
	^ true
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> isImmediateU16 [
	^ self isImmediate16
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> isImmediateU32 [
	^ self isImmediate32
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> isImmediateU64 [
	^ self isImmediate64
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> isImmediateU8 [
	^ self isImmediate8
]

{ #category : #testing }
SAsmImmediateSymbolWithAddend >> isRelativeGlobalOffsetTable [
	^ relocationKind == #'relative-global-offset-table'
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> makeGOT [
	relocationKind := #got
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> makeGOTOffset [
	relocationKind := #'got-offset'
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> makeRelativeGlobalOffsetTable [
	relocationKind := #'relative-global-offset-table'
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> makeSectionRelative [
	relocationKind := #sectionRelative
]

{ #category : #'as yet unclassified' }
SAsmImmediateSymbolWithAddend >> positionValue [
	^ symbol positionValue ifNil: [addend] ifNotNil: [:pos | pos + addend]
]

{ #category : #printing }
SAsmImmediateSymbolWithAddend >> prettyPrintOn: aStream [
	symbol prettyPrintOn: aStream.
	addend ~= 0 ifTrue: [ aStream nextPutAll: ' + '; print: addend ]
]

{ #category : #printing }
SAsmImmediateSymbolWithAddend >> printOn: aStream [
	aStream print: symbol.
	addend ~= 0 ifTrue: [ aStream nextPutAll: ' + '; print: addend ]
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> sectionRelative [
	^ relocationKind == #sectionRelative
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> size [
	^ size
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> size: anObject [
	size := anObject
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> symbol [
	^ symbol
]

{ #category : #accessing }
SAsmImmediateSymbolWithAddend >> symbol: anObject [
	symbol := anObject
]
