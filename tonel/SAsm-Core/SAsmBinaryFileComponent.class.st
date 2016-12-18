Class {
	#name : #SAsmBinaryFileComponent,
	#superclass : #Object,
	#instVars : [
		'fileOffset'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #accessing }
SAsmBinaryFileComponent >> alignment [
	^ 1
]

{ #category : #accessing }
SAsmBinaryFileComponent >> fileOffset [
	^ fileOffset
]

{ #category : #accessing }
SAsmBinaryFileComponent >> fileOffset: anObject [
	fileOffset := anObject
]

{ #category : #writing }
SAsmBinaryFileComponent >> prepareForWritingToFile [
	"Do nothing for now"
]

{ #category : #accessing }
SAsmBinaryFileComponent >> size [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
SAsmBinaryFileComponent >> writeToFileNamed: aFileName [
	aFileName asFileReference writeStreamDo: [ :out | out binary. self writeOn: out ]
]
