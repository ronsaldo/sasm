Class {
	#name : #SAsmDWExpressionBuilder,
	#superclass : #SAsmDWObject,
	#instVars : [
		'stream'
	],
	#pools : [
		'SAsmDWConstants'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #building }
SAsmDWExpressionBuilder class >> build: aBlock [
	^ self new build: aBlock
]

{ #category : #building }
SAsmDWExpressionBuilder >> add: anInstruction [
	stream nextPut: anInstruction
]

{ #category : #building }
SAsmDWExpressionBuilder >> addr: anAddress [
	self add: (SAsmDWExpressionInstructionAddr new value: anAddress)
]

{ #category : #building }
SAsmDWExpressionBuilder >> build: aBlock [
	^ Array streamContents: [ :out |
		stream := out.
		aBlock value: self
	]
]
