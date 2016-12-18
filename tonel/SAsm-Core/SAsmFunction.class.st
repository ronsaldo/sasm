Class {
	#name : #SAsmFunction,
	#superclass : #SAsmModuleElement,
	#instVars : [
		'basicBlocks',
		'name',
		'instructionLowerer',
		'callingConvention'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #adding }
SAsmFunction >> addBasicBlock: aBasicBlock [
	aBasicBlock function: self.
	basicBlocks add: aBasicBlock.
	^ aBasicBlock
]

{ #category : #'abstract instruction generation' }
SAsmFunction >> allocateRegisterFor: aStreamBuilder [
	instructionLowerer := target createInstructionLowerer.
	instructionLowerer function: self;
		streamBuilder: aStreamBuilder
	
]

{ #category : #'calling conventions' }
SAsmFunction >> apicall [
	self callingConvention: target apicallCallingConvention
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

{ #category : #accessing }
SAsmFunction >> callingConvention [
	^ callingConvention
]

{ #category : #accessing }
SAsmFunction >> callingConvention: anObject [
	callingConvention := anObject
]

{ #category : #'calling conventions' }
SAsmFunction >> cdecl [
	self callingConvention: target cdeclCallingConvention
]

{ #category : #printing }
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

{ #category : #'abstract instruction generation' }
SAsmFunction >> lowerInstruction: instruction writeToStream: aStreamBuilder [
	instructionLowerer lowerInstruction: instruction writeToStream: aStreamBuilder
]

{ #category : #'calling conventions' }
SAsmFunction >> naked [
	self callingConvention: target nakedCallingConvention
]

{ #category : #accessing }
SAsmFunction >> name [
	^ name
]

{ #category : #accessing }
SAsmFunction >> name: anObject [
	name := anObject
]

{ #category : #printing }
SAsmFunction >> prettyPrintOn: aStream [
	aStream putKeyword: 'function'; space; putIdentifier: self validName
]

{ #category : #printing }
SAsmFunction >> printOn: aStream [
	aStream nextPutAll: 'function '; nextPutAll: self validName
]

{ #category : #'calling conventions' }
SAsmFunction >> smalltalk [
	self callingConvention: target smalltalkCallingConvention
]

{ #category : #'calling conventions' }
SAsmFunction >> stdcall [
	self callingConvention: target stdcallCallingConvention
]

{ #category : #accessing }
SAsmFunction >> target: aCompilationTarget [
	super target: aCompilationTarget.
	callingConvention := aCompilationTarget defaultCallingConvention.
]

{ #category : #accessing }
SAsmFunction >> validName [
	^ name ifNil: [ #anonymous ]
]

{ #category : #writing }
SAsmFunction >> writeToStream: aStreamBuilder [
	aStreamBuilder withNewLocalScope: [
		aStreamBuilder textSection.
		self allocateRegisterFor: aStreamBuilder.
		basicBlocks do: [ :bb | bb prepareWriteToStream: aStreamBuilder ].
		
		aStreamBuilder label: (aStreamBuilder findSymbolForObject: self).
		instructionLowerer enterFrame.
		basicBlocks do: [ :bb | bb writeToStream: aStreamBuilder ].
	]
]
