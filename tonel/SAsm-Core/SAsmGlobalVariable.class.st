Class {
	#name : #SAsmGlobalVariable,
	#superclass : #SAsmModuleElement,
	#instVars : [
		'name',
		'content'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #accessing }
SAsmGlobalVariable >> content [
	^ content
]

{ #category : #accessing }
SAsmGlobalVariable >> content: anObject [
	content := anObject
]

{ #category : #printing }
SAsmGlobalVariable >> fullPrintOn: aStream [
	self isEmpty ifTrue: [
		self prettyPrintOn: aStream.
		aStream nextPut: $;; lf.
		^ self
	].

	aStream putKeyword: 'variable'; space; putIdentifier: self validName; nextPutAll:  ' = {'; lf.
	aStream withExtraIndentationLevel: [
		content fullPrintOn: aStream.
	].
	aStream nextPutAll: '}'; lf
]

{ #category : #testing }
SAsmGlobalVariable >> isEmpty [
	^ content isNil
]

{ #category : #accessing }
SAsmGlobalVariable >> name [
	^ name
]

{ #category : #accessing }
SAsmGlobalVariable >> name: anObject [
	name := anObject
]

{ #category : #printing }
SAsmGlobalVariable >> prettyPrintOn: aStream [
	aStream putKeyword: 'variable'; space; putIdentifier: self validName
]

{ #category : #printing }
SAsmGlobalVariable >> printOn: aStream [
	aStream nextPutAll: 'variable '; nextPutAll: self validName
]

{ #category : #accessing }
SAsmGlobalVariable >> validName [
	^ name ifNil: [ #anonymous ]
]

{ #category : #writing }
SAsmGlobalVariable >> writeToStream: aStreamBuilder [
	self isEmpty ifTrue: [ ^ self ].
	
	aStreamBuilder withNewLocalScope: [
		aStreamBuilder dataSection.
		aStreamBuilder label: (aStreamBuilder findSymbolForObject: self).
		
		content writeToStream: aStreamBuilder.
	]
]
