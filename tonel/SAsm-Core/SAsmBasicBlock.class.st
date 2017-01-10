Class {
	#name : #SAsmBasicBlock,
	#superclass : #SAsmStream,
	#instVars : [
		'function',
		'name',
		'index'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #printing }
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

{ #category : #accessing }
SAsmBasicBlock >> index [
	^ index
]

{ #category : #accessing }
SAsmBasicBlock >> index: anObject [
	index := anObject
]

{ #category : #'instruction lowering' }
SAsmBasicBlock >> lowerInstruction: instruction andWriteToStream: aStreamBuilder [
	instruction isThreeAddressInstruction ifTrue: [ 
		^ function lowerInstruction: instruction writeToStream: aStreamBuilder.
	] ifFalse: [ 
		instruction writeToStream: aStreamBuilder.
		^ instruction next
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

{ #category : #writing }
SAsmBasicBlock >> prepareWriteToStream: aStreamBuilder [
	aStreamBuilder addPrivateSymbol: name for: self.
	super prepareWriteToStream: aStreamBuilder
]

{ #category : #printing }
SAsmBasicBlock >> prettyPrintOn: aStream [
	aStream putIdentifier: self validName
]

{ #category : #printing }
SAsmBasicBlock >> printOn: aStream [
	aStream nextPutAll: self validName
]

{ #category : #accessing }
SAsmBasicBlock >> validName [
	^ name ifNil: [ #unnamed ].
]

{ #category : #writing }
SAsmBasicBlock >> writeToStream: aStreamBuilder [
	| nextInstruction |
	aStreamBuilder label: (aStreamBuilder findSymbolForObject: self).
	nextInstruction := first.
	[nextInstruction] whileNotNil: [ 
		nextInstruction := self lowerInstruction: nextInstruction andWriteToStream: aStreamBuilder.
	]
]
