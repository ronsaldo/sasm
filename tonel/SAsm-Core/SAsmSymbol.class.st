Class {
	#name : #SAsmSymbol,
	#superclass : #SAsmInstructionOperand,
	#instVars : [
		'name',
		'visibility',
		'section',
		'value'
	],
	#classVars : [
		'PrivateVisibility'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'as yet unclassified' }
SAsmSymbol class >> initialize [
	super initialize.
	PrivateVisibility := #private
]

{ #category : #accessing }
SAsmSymbol >> fullPrintOn: aStream [
	aStream putIdentifier: self validName
]

{ #category : #testing }
SAsmSymbol >> isSymbol [
	^ true
]

{ #category : #visibility }
SAsmSymbol >> makePrivate [
	visibility := PrivateVisibility
]

{ #category : #accessing }
SAsmSymbol >> name [
	^ name
]

{ #category : #accessing }
SAsmSymbol >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SAsmSymbol >> section [
	^ section
]

{ #category : #accessing }
SAsmSymbol >> section: anObject [
	section := anObject
]

{ #category : #accessing }
SAsmSymbol >> validName [
	^ name ifNil: [ #anonsymbol ]
]

{ #category : #accessing }
SAsmSymbol >> value [
	^ value
]

{ #category : #accessing }
SAsmSymbol >> value: anObject [
	value := anObject
]

{ #category : #accessing }
SAsmSymbol >> visibility [
	^ visibility
]

{ #category : #accessing }
SAsmSymbol >> visibility: anObject [
	visibility := anObject
]
