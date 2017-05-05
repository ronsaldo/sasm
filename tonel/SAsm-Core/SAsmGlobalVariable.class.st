Class {
	#name : #SAsmGlobalVariable,
	#superclass : #SAsmModuleElement,
	#instVars : [
		'name'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #printing }
SAsmGlobalVariable >> fullPrintOn: aStream [
	self isExternal ifTrue: [
		self prettyPrintOn: aStream.
		aStream nextPut: $;; lf.
		^ self
	].

	aStream putKeyword: 'variable'; space; putIdentifier: self validName; nextPutAll:  ' = {'; lf.
	aStream withExtraIndentationLevel: [
		self flag: 'TODO: Print the content of the variable.'.
	].
	aStream nextPutAll: '}'; lf
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
	self isExternal ifTrue: [ ^ self ].
	
	aStreamBuilder withNewLocalScope: [
		aStreamBuilder dataSection.
		aStreamBuilder label: (aStreamBuilder findSymbolForObject: self).
		
		self flag: 'emit the content of the variable'
	]
]
