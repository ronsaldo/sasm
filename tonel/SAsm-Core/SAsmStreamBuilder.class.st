Class {
	#name : #SAsmStreamBuilder,
	#superclass : #Object,
	#instVars : [
		'stream',
		'localScope',
		'currentSection'
	],
	#pools : [
		'SAsmTacOperations'
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
	anObject ifNil: [ ^ nil ].
	^ localScope findMappedSymbolRecursively: anObject
]

{ #category : #symbols }
SAsmStreamBuilder >> findSymbolForObject: anObject ifAbsent: aBlock [
	^ localScope findMappedSymbolRecursively: anObject ifAbsent: aBlock
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

{ #category : #symbols }
SAsmStreamBuilder >> newPrivateSymbol: name [
	^ SAsmSymbol new
		name: name;
		makePrivate;
		yourself
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

{ #category : #'three address code' }
SAsmStreamBuilder >> tacAdd: left with: right into: result [
	^ self tacOperation: TacAdd result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacBoolRegister [
	^ stream function newIntegerVirtualRegister.
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacBranch: condition true: trueDestination false: falseDestintion [
	^ self add: (SAsmTacBranchInstruction new
		condition: condition;
		trueDestination: trueDestination;
		falseDestination: falseDestintion;
		yourself)
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacCall: called into: result [
	^ self tacOperation: TacCall result: result value: called
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacDivide: left with: right into: result [
	^ self tacOperation: TacDivide result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacDoubleFloatRegister [
	^ stream function newDoubleFloatVirtualRegister.
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacEqual: left with: right into: result [
	^ self tacOperation: TacEqual result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacFloatRegister [
	^ stream function newFloatVirtualRegister.
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacGreater: left with: right into: result [
	^ self tacOperation: TacGreater result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacGreaterOrEqual: left with: right into: result [
	^ self tacOperation: TacGreaterOrEqual result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacIntRegister [
	^ stream function newIntegerVirtualRegister.
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacJump: destination [
	^ self add: (SAsmTacJumpInstruction new
		destination: destination;
		yourself)
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLess: left with: right into: result [
	^ self tacOperation: TacLess result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLessOrEqual: left with: right into: result [
	^ self tacOperation: TacLessOrEqual result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacMove: source into: destination [
	^ self tacOperation: TacMove result: destination value: source
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacMultiply: left with: right into: result [
	^ self tacOperation: TacMultiply result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacNotEqual: left with: right into: result [
	^ self tacOperation: TacNotEqual result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacOperation: operation [
	^ self tacOperation: operation result: nil left: nil right: nil
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacOperation: operation result: result left: left right: right [
	^ self add: (SAsmTacInstruction new
		operation: operation;
		result: result asSAsmInstructionOperand;
		left: left asSAsmInstructionOperand;
		right: right asSAsmInstructionOperand;
		yourself)
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacOperation: operation result: result value: value [
	^ self tacOperation: operation result: result left: value right: nil
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacOperation: operation value: value [
	^ self tacOperation: operation result: nil left: value right: nil
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacReturn: value [
	^ self tacOperation: TacReturn value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacReturnVoid [
	^ self tacOperation: TacReturn
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacSubtract: left with: right into: result [
	^ self tacOperation: TacSubtract result: result left: left right: right
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
