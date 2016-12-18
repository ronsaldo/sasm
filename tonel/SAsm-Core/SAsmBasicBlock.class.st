Class {
	#name : #SAsmBasicBlock,
	#superclass : #SAsmStream,
	#instVars : [
		'function',
		'name'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'as yet unclassified' }
SAsmBasicBlock >> fullPrintOn: aStream [
	aStream putIdentifier: self validName; nextPutAll: ' {'; lf.
	aStream withExtraIndentationLevel: [ 
		self do: [ :instruction |
			instruction fullPrintOn: aStream.
			aStream lf
		].
	].
	aStream nextPutAll: '}'; lf.
]

{ #category : #accessing }
SAsmBasicBlock >> function [
	^ function
]

{ #category : #accessing }
SAsmBasicBlock >> function: anObject [
	function := anObject.
	target := function target.
]

{ #category : #'as yet unclassified' }
SAsmBasicBlock >> lowerInstruction: instruction andWriteToStream: aStreamBuilder [
	instruction isThreeAddressInstruction ifTrue: [ 
		function lowerInstruction: instruction writeToStream: aStreamBuilder.
	] ifFalse: [ 
		instruction writeToStream: aStreamBuilder.
	].
	
]

{ #category : #accessing }
SAsmBasicBlock >> name [
	^ name
]

{ #category : #accessing }
SAsmBasicBlock >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
SAsmBasicBlock >> prepareWriteToStream: aStreamBuilder [
	aStreamBuilder addPrivateSymbol: name for: self.
	super prepareWriteToStream: aStreamBuilder
]

{ #category : #'as yet unclassified' }
SAsmBasicBlock >> validName [
	^ name ifNil: [ #unnamed ].
]

{ #category : #'as yet unclassified' }
SAsmBasicBlock >> writeToStream: aStreamBuilder [
	aStreamBuilder label: (aStreamBuilder findSymbolForObject: self).
	self do: [ :instruction |
		self lowerInstruction: instruction andWriteToStream: aStreamBuilder.
	]
]
