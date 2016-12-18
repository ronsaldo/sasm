Class {
	#name : #SAsmFunction,
	#superclass : #SAsmModuleElement,
	#instVars : [
		'basicBlocks',
		'name'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #adding }
SAsmFunction >> addBasicBlock: aBasicBlock [
	aBasicBlock function: self.
	basicBlocks add: aBasicBlock.
	^ aBasicBlock
]

{ #category : #accessing }
SAsmFunction >> basicBlocks [
	^ basicBlocks
]

{ #category : #building }
SAsmFunction >> build: aBlock [
	aBlock value: (SAsmFunctionBuilder new function: self).
	^ self
]

{ #category : #'as yet unclassified' }
SAsmFunction >> fullPrintOn: aStream [
	aStream putKeyword: 'function'; space; putIdentifier: self validName; nextPutAll:  ' = {'; lf.
	aStream withExtraIndentationLevel: [
		basicBlocks do: [ :bb | bb fullPrintOn: aStream ]
	].
	aStream nextPutAll: '}'; lf
]

{ #category : #'gt-inspector-extension' }
SAsmFunction >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ basicBlocks gtInspectorItemsIn: composite
]

{ #category : #'gt-inspector-extension' }
SAsmFunction >> gtInspectorModuleText: composite [
	<gtInspectorPresentationOrder: 0>  
	^ (composite text)
		title: 'Function Assembly';
		format: #fullPrintText
]

{ #category : #initialization }
SAsmFunction >> initialize [
	super initialize.
	basicBlocks := OrderedCollection new.
	
]

{ #category : #'as yet unclassified' }
SAsmFunction >> name [
	^ name
]

{ #category : #accessing }
SAsmFunction >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
SAsmFunction >> printOn: aStream [
	aStream nextPutAll: 'function '; nextPutAll: self validName
]

{ #category : #'as yet unclassified' }
SAsmFunction >> validName [
	^ name ifNil: [ #anonymous ]
]

{ #category : #'as yet unclassified' }
SAsmFunction >> writeToStream: aStreamBuilder [
	aStreamBuilder withNewLocalScope: [
		basicBlocks do: [ :bb | bb prepareWriteToStream: aStreamBuilder ].
		aStreamBuilder textSection.
		basicBlocks do: [ :bb | bb writeToStream: aStreamBuilder ].
	]
]
