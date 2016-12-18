Class {
	#name : #SAsmBinaryObject,
	#superclass : #Object,
	#instVars : [
		'sections'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #comparing }
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

{ #category : #writing }
SAsmBinaryObject >> writeToFileNamed: aFileName [
	aFileName asFileReference writeStreamDo: [ :out | out binary.
		sections do: [ :section |
			out nextPutAll: section data
		]
	]
]
