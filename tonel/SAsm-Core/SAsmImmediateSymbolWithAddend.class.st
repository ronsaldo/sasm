Class {
	#name : #SAsmImmediateSymbolWithAddend,
	#superclass : #SAsmImmediate,
	#instVars : [
		'size',
		'symbol',
		'addend'
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

{ #category : #'as yet unclassified' }
SAsmImmediateSymbolWithAddend >> copyWithStreamBuilder: streamBuilder [
	^ self copy symbol: (streamBuilder findSymbolForObject: symbol)
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
	^ size = 2
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
	(anInstruction section name ~= symbol sectionName) ifTrue: [ ^ false ].
	^ super isImmediateS8RelativeTo: anInstruction section position: immediateWritePosition offset: relativeCheck
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

{ #category : #printing }
SAsmImmediateSymbolWithAddend >> prettyPrintOn: aStream [
	symbol prettyPrintOn: aStream.
	addend ~= 0 ifTrue: [ aStream space; print: addend ]
]

{ #category : #printing }
SAsmImmediateSymbolWithAddend >> printOn: aStream [
	aStream print: symbol.
	addend ~= 0 ifTrue: [ aStream space; print: addend ]
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