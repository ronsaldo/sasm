Class {
	#name : #SAsmBinaryObjectWriterLabel,
	#superclass : #Object,
	#instVars : [
		'label',
		'shortLongBranchesPrecedingCount'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #accessing }
SAsmBinaryObjectWriterLabel >> label [
	^ label
]

{ #category : #accessing }
SAsmBinaryObjectWriterLabel >> label: anObject [
	label := anObject
]

{ #category : #accessing }
SAsmBinaryObjectWriterLabel >> shortLongBranchesPrecedingCount [
	^ shortLongBranchesPrecedingCount
]

{ #category : #accessing }
SAsmBinaryObjectWriterLabel >> shortLongBranchesPrecedingCount: anObject [
	shortLongBranchesPrecedingCount := anObject
]
