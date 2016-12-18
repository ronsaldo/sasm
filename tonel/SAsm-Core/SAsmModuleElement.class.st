Class {
	#name : #SAsmModuleElement,
	#superclass : #SAsmObject,
	#traits : 'TSAsmVisibility',
	#classTraits : 'TSAsmVisibility classTrait',
	#instVars : [
		'visibility',
		'target'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #converting }
SAsmModuleElement >> asSAsmInstructionOperand [
	^ SAsmImmediateSymbolWithAddend new
		symbol: self;
		size: target pointerSize;
		yourself
]

{ #category : #'as yet unclassified' }
SAsmModuleElement >> initialize [
	super initialize.
	self makeExternal.
]

{ #category : #writing }
SAsmModuleElement >> prepareWriteToStream: streamBuilder [
	self name isNotNil ifTrue: [
		(streamBuilder addSymbol: self name for: self)
			visibility: self visibility.
	].
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
