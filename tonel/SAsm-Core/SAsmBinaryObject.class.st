Class {
	#name : #SAsmBinaryObject,
	#superclass : #Object,
	#instVars : [
		'sections'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #'as yet unclassified' }
SAsmBinaryObject >> = other [
	^ self class = other class
		and: [ sections = other sections ]
]

{ #category : #accessing }
SAsmBinaryObject >> sections [
	^ sections
]

{ #category : #accessing }
SAsmBinaryObject >> sections: anObject [
	sections := anObject
]
