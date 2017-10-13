Class {
	#name : #SAsmBinaryObjectWriterLabel,
	#superclass : #Object,
	#instVars : [
		'label',
		'dependencies'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #accessing }
SAsmBinaryObjectWriterLabel >> dependencies [
	^ dependencies
]

{ #category : #accessing }
SAsmBinaryObjectWriterLabel >> dependencies: anObject [
	dependencies := anObject
]

{ #category : #accessing }
SAsmBinaryObjectWriterLabel >> label [
	^ label
]

{ #category : #accessing }
SAsmBinaryObjectWriterLabel >> label: anObject [
	label := anObject
]
