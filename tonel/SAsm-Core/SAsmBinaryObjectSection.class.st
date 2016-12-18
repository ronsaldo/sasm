Class {
	#name : #SAsmBinaryObjectSection,
	#superclass : #Object,
	#instVars : [
		'name',
		'data'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #'as yet unclassified' }
SAsmBinaryObjectSection >> = other [
	^ self class = other class
		and: [ name = other name
		and: [ data = other data ]]
]

{ #category : #accessing }
SAsmBinaryObjectSection >> data [
	^ data
]

{ #category : #accessing }
SAsmBinaryObjectSection >> data: anObject [
	data := anObject
]

{ #category : #accessing }
SAsmBinaryObjectSection >> name [
	^ name
]

{ #category : #accessing }
SAsmBinaryObjectSection >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SAsmBinaryObjectSection >> size [
	^ data size
]
