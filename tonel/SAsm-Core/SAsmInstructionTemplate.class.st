Class {
	#name : #SAsmInstructionTemplate,
	#superclass : #SAsmObject,
	#instVars : [
		'name'
	],
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'as yet unclassified' }
SAsmInstructionTemplate >> computeMaximalSizeFor: anInstruction [
	self subclassResponsibility
]

{ #category : #accessing }
SAsmInstructionTemplate >> name [
	^ name
]

{ #category : #accessing }
SAsmInstructionTemplate >> name: anObject [
	name := anObject
]
