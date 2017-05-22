Class {
	#name : #SAsmElfSectionHeader,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'content',
		'index'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #accessing }
SAsmElfSectionHeader >> content [
	^ content
]

{ #category : #accessing }
SAsmElfSectionHeader >> content: anObject [
	content := anObject
]

{ #category : #accessing }
SAsmElfSectionHeader >> index [
	^ index
]

{ #category : #accessing }
SAsmElfSectionHeader >> index: anObject [
	index := anObject
]

{ #category : #writing }
SAsmElfSectionHeader >> prepareForWritingToFile [
	content ifNil: [ ^ self ].
	
	self offset: content fileOffset.
	self contentSize: content size.

]
