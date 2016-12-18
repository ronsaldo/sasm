Class {
	#name : #SAsmStreamBuilder,
	#superclass : #Object,
	#instVars : [
		'stream',
		'localScope',
		'currentSection'
	],
	#category : #'SAsm-Core-Builder'
}

{ #category : #constants }
SAsmStreamBuilder >> add: value [
	^ stream add: value
]

{ #category : #symbols }
SAsmStreamBuilder >> addPrivateSymbol: name for: anObject [
	^ (self addSymbol: name for: anObject)
		makePrivate;
		yourself
]

{ #category : #symbols }
SAsmStreamBuilder >> addSymbol: name for: anObject [
	| symbol |
	symbol := SAsmSymbol new name: name.
	localScope addMapToObject: anObject symbol: symbol.
	^ symbol
]

{ #category : #symbols }
SAsmStreamBuilder >> addSymbolCopy: aSymbol [
	localScope findMappedSymbolRecursively: aSymbol ifAbsent: [
		localScope addMapToObject: aSymbol symbol: aSymbol copy
	]
]

{ #category : #constants }
SAsmStreamBuilder >> constI16: value [
	^ self add: (SAsmConstantExpressionValue new
		size: 2;
		value: value asSAsmConstantExpression;
		yourself).
]

{ #category : #constants }
SAsmStreamBuilder >> constI32: value [
	^ self add: (SAsmConstantExpressionValue new
		size: 4;
		value: value asSAsmConstantExpression;
		yourself).
]

{ #category : #constants }
SAsmStreamBuilder >> constI64: value [
	^ self add: (SAsmConstantExpressionValue new
		size: 8;
		value: value asSAsmConstantExpression;
		yourself).
]

{ #category : #constants }
SAsmStreamBuilder >> constI8: value [
	^ self add: (SAsmConstantExpressionValue new
		size: 1;
		value: value asSAsmConstantExpression;
		yourself).
]

{ #category : #sections }
SAsmStreamBuilder >> currentSectionName [
	currentSection ifNil: [ ^ #'..nil..' ].
	^ currentSection name
]

{ #category : #symbols }
SAsmStreamBuilder >> findSymbolForObject: anObject [
	^ localScope findMappedSymbolRecursively: anObject
]

{ #category : #initialization }
SAsmStreamBuilder >> initialize [
	super initialize.
	localScope := SAsmStreamBuilderLocalScope empty
]

{ #category : #symbols }
SAsmStreamBuilder >> label: aSymbol [
	self add: (SAsmLabel new symbol: aSymbol)
]

{ #category : #accessing }
SAsmStreamBuilder >> localScope [
	^ localScope
]

{ #category : #sections }
SAsmStreamBuilder >> startSection: sectionName attributes: aBlock [
	self currentSectionName = sectionName ifTrue: [ ^ currentSection ].
	currentSection := SAsmSection new name: sectionName.
	aBlock value: currentSection.
	^ self add: currentSection
]

{ #category : #accessing }
SAsmStreamBuilder >> stream [
	^ stream
]

{ #category : #accessing }
SAsmStreamBuilder >> stream: anObject [
	stream := anObject
]

{ #category : #sections }
SAsmStreamBuilder >> textSection [
	^ self startSection: #'.text' attributes: [ :section |
		section 
			loaded: true;
			executable: true;
			readable: true;
			writeable: false
	]
]

{ #category : #symbols }
SAsmStreamBuilder >> withNewLocalScope: aBlock [
	| oldLocalScope |
	oldLocalScope := localScope.
	localScope  := SAsmStreamBuilderLocalScope parent: localScope.
	aBlock ensure: [ localScope := oldLocalScope ]
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation [
	^ self x86: operation withOperands: #()
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation dst: operand1 src: operand2 [
	^ self x86: operation with: operand1 with: operand2
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation src: operand1 dst: operand2 [
	^ self x86: operation with: operand2 with: operand1
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation with: operand1 [
	^ self x86: operation withOperands: { operand1 asSAsmInstructionOperand }
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation with: operand1 with: operand2 [
	^ self x86: operation withOperands: { operand1 asSAsmInstructionOperand . operand2 asSAsmInstructionOperand }
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation withOperands: operands [
	^ self add: (
		SAsmInstruction new
			template: operation;
			arguments: operands;
			yourself)
]
