Class {
	#name : #SAsmGlobalVariable,
	#superclass : #SAsmModuleElement,
	#instVars : [
		'name',
		'headerContent',
		'content',
		'size',
		'alignment',
		'customSection',
		'header'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #accessing }
SAsmGlobalVariable >> alignment [
	^ alignment
]

{ #category : #accessing }
SAsmGlobalVariable >> alignment: anObject [
	alignment := anObject
]

{ #category : #accessing }
SAsmGlobalVariable >> content [
	^ content
]

{ #category : #accessing }
SAsmGlobalVariable >> content: anObject [
	content := anObject
]

{ #category : #accessing }
SAsmGlobalVariable >> customSection [
	^ customSection
]

{ #category : #accessing }
SAsmGlobalVariable >> customSection: anObject [
	customSection := anObject
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

{ #category : #accessing }
SAsmGlobalVariable >> headerContent [
	^ headerContent
]

{ #category : #accessing }
SAsmGlobalVariable >> headerContent: anObject [
	headerContent := anObject
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

{ #category : #writing }
SAsmGlobalVariable >> prepareWriteToStream: streamBuilder [
	super prepareWriteToStream: streamBuilder.
	header ifNotNil: [ 
		(streamBuilder addSymbol: nil for: header)
			visibility: #private
	]

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
SAsmGlobalVariable >> requiredHeader [
	^ header ifNil: [ header := SAsmGlobalVariableHeader new globalVariable: self ]

]

{ #category : #accessing }
SAsmGlobalVariable >> size [
	^ size
]

{ #category : #accessing }
SAsmGlobalVariable >> size: anObject [
	size := anObject
]

{ #category : #accessing }
SAsmGlobalVariable >> validName [
	^ name ifNil: [ #anonymous ]
]

{ #category : #writing }
SAsmGlobalVariable >> writeToStream: aStreamBuilder [
	(self isEmpty and: [self isExternal]) ifTrue: [ ^ self ].
	
	aStreamBuilder withNewLocalScope: [
		(content isNil and: [header isNil and: [headerContent isNil and: [customSection isNil]]]) ifTrue: [
			aStreamBuilder bssSection.
			aStreamBuilder
				align: alignment;
				label: (aStreamBuilder findSymbolForObject: self);
				zeros: size.
		] ifFalse: [ 
			aStreamBuilder dataSectionNamed: customSection.
			header ifNotNil: [
				aStreamBuilder
					label: (aStreamBuilder findSymbolForObject: header).
			].
		
			headerContent ifNotNil: [
				headerContent writeToStream: aStreamBuilder
			].
		
			aStreamBuilder
				align: alignment;
				label: (aStreamBuilder findSymbolForObject: self).
		
			content ifNotNil: [ 
				content writeToStream: aStreamBuilder
			] ifNil: [
				aStreamBuilder zeros: size.
			]
		]
	]
]
