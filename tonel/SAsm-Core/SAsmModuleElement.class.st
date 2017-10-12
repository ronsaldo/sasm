Class {
	#name : #SAsmModuleElement,
	#superclass : #SAsmObject,
	#traits : 'TSAsmVisibility',
	#classTraits : 'TSAsmVisibility classTrait',
	#instVars : [
		'visibility',
		'target',
		'debugName'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #converting }
SAsmModuleElement >> asGOTReference [
	^ SAsmImmediateSymbolWithAddend new
		symbol: self;
		size: target pointerSize;
		makeGOT;
		yourself
]

{ #category : #converting }
SAsmModuleElement >> asSAsmInstructionOperand [
	^ SAsmImmediateSymbolWithAddend new
		symbol: self;
		size: target pointerSize;
		yourself
]

{ #category : #accessing }
SAsmModuleElement >> debugName [
	^ debugName
]

{ #category : #accessing }
SAsmModuleElement >> debugName: anObject [
	debugName := anObject
]

{ #category : #'as yet unclassified' }
SAsmModuleElement >> initialize [
	super initialize.
	self makeExternal.
]

{ #category : #testing }
SAsmModuleElement >> isLastElement [
	^ false
]

{ #category : #writing }
SAsmModuleElement >> prepareWriteToStream: streamBuilder [
	self name isNotNil ifTrue: [
		(streamBuilder addSymbol: self name for: self)
			visibility: self visibility.
	] ifFalse: [
		(streamBuilder addSymbol: nil for: self)
			visibility: #private.
	]
]

{ #category : #accessing }
SAsmModuleElement >> target [
	^ target
]

{ #category : #accessing }
SAsmModuleElement >> target: anObject [
	target := anObject
]

{ #category : #accessing }
SAsmModuleElement >> visibility [
	^ visibility
]

{ #category : #accessing }
SAsmModuleElement >> visibility: anObject [
	visibility := anObject
]

{ #category : #writing }
SAsmModuleElement >> writeToStream: aStreamBuilder [
	self subclassResponsibility
]
