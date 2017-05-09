Class {
	#name : #SAsmFunction,
	#superclass : #SAsmModuleElement,
	#instVars : [
		'basicBlocks',
		'name',
		'instructionLowerer',
		'callingConvention',
		'virtualRegisters',
		'stackFrameLayout',
		'constantZone',
		'constantZoneBuilder'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'abstract instruction adding' }
SAsmFunction >> addArgumentVirtualRegister: virtualRegister name: argumentName [
	| variable |
	variable := stackFrameLayout createArgument: virtualRegister size alignment: virtualRegister alignment dynamicRoot: false.
	virtualRegister variable: variable.
	^ virtualRegister
]

{ #category : #adding }
SAsmFunction >> addBasicBlock: aBasicBlock [
	aBasicBlock function: self.
	basicBlocks add: aBasicBlock.
	^ aBasicBlock
]

{ #category : #'abstract instruction adding' }
SAsmFunction >> addVirtualRegister: virtualRegister [
	virtualRegisters add: virtualRegister.
	virtualRegister index: virtualRegisters size.
	^ virtualRegister
]

{ #category : #'abstract instruction adding' }
SAsmFunction >> addVirtualRegisters: newVirtualRegisters [
	newVirtualRegisters do: [ :reg | self addVirtualRegister: reg ].
	^ newVirtualRegisters
]

{ #category : #'abstract instruction generation' }
SAsmFunction >> allocateRegisterFor: aStreamBuilder [
	instructionLowerer := target createInstructionLowerer.
	instructionLowerer function: self;
		streamBuilder: aStreamBuilder;
		allocateRegisters
	
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

{ #category : #accessing }
SAsmFunction >> callingConventionNamed: aName [
	self callingConvention: (target callingConventionNamed: aName)
]

{ #category : #'calling conventions' }
SAsmFunction >> cdecl [
	self callingConvention: target cdeclCallingConvention
]

{ #category : #'linear scan' }
SAsmFunction >> computeVirtualRegisterLiveRanges [
	virtualRegisters do: #resetRange.
	self
		enumerateInstructionPositions;
		markVirtualRegisterLiveRanges.
]

{ #category : #accessing }
SAsmFunction >> constantZone [
	^ constantZone ifNil: [ constantZone := SAsmStream new target: target; yourself]
]

{ #category : #accessing }
SAsmFunction >> constantZoneBuilder [
	^ constantZoneBuilder ifNil: [ constantZoneBuilder := SAsmStreamBuilder new stream: self constantZone ]
]

{ #category : #'linear scan' }
SAsmFunction >> enumerateInstructionPositions [
	| index |
	index := 1.
	basicBlocks do: [ :bb |
		bb index: index.
		bb maxPredecessorIndex: -1.
		index := index + 1.
		bb do: [ :instruction |
			instruction index: index.
			index := index + 1
		]
	].

			
]

{ #category : #printing }
SAsmFunction >> fullPrintOn: aStream [
	self isEmpty ifTrue: [
		self prettyPrintOn: aStream.
		aStream nextPut: $;; lf.
		^ self
	].

	aStream putKeyword: 'function'; space; putIdentifier: self validName; nextPutAll:  ' = {'; lf.
	aStream withExtraIndentationLevel: [
		basicBlocks do: [ :bb | bb fullPrintOn: aStream ].
		
		constantZone ifNotNil: [ constantZone fullPrintOn: aStream ].
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
	virtualRegisters := OrderedCollection new.
	stackFrameLayout := SAsmStackFrameLayout new.
]

{ #category : #testing }
SAsmFunction >> isEmpty [
	^ basicBlocks isEmpty
]

{ #category : #'abstract instruction generation' }
SAsmFunction >> lowerInstruction: instruction writeToStream: aStreamBuilder [
	^ instructionLowerer lowerInstruction: instruction writeToStream: aStreamBuilder
]

{ #category : #'linear scan' }
SAsmFunction >> markVirtualRegisterLiveRanges [
	basicBlocks do: [ :bb |
		bb do: [ :instruction |
			instruction markVirtualRegisterLiveAt: instruction index
		]
	]
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

{ #category : #'abstract instruction adding' }
SAsmFunction >> newDoubleFloatArgument: argumentName [
	^ self addArgumentVirtualRegister: self newDoubleFloatVirtualRegister name: argumentName
]

{ #category : #'abstract instruction adding' }
SAsmFunction >> newDoubleFloatVirtualRegister [
	^ self addVirtualRegister: target newDoubleFloatVirtualRegister
]

{ #category : #'abstract instruction adding' }
SAsmFunction >> newFloatArgument: argumentName [
	^ self addArgumentVirtualRegister: self newFloatVirtualRegister name: argumentName
]

{ #category : #'abstract instruction adding' }
SAsmFunction >> newFloatVirtualRegister [
	^ self addVirtualRegister: target newFloatVirtualRegister
]

{ #category : #'abstract instruction adding' }
SAsmFunction >> newIntegerArgument: argumentName [
	^ self addArgumentVirtualRegister: self newIntegerVirtualRegister name: argumentName
]

{ #category : #'abstract instruction adding' }
SAsmFunction >> newIntegerVirtualRegister [
	^ self addVirtualRegister: target newIntegerVirtualRegister
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

{ #category : #accessing }
SAsmFunction >> stackFrameLayout [
	^ stackFrameLayout
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

{ #category : #accessing }
SAsmFunction >> virtualRegisters [
	^ virtualRegisters
]

{ #category : #writing }
SAsmFunction >> writeToStream: aStreamBuilder [
	self isEmpty ifTrue: [ ^ self ].
	
	aStreamBuilder withNewLocalScope: [
		aStreamBuilder textSection.
		self allocateRegisterFor: aStreamBuilder.
		basicBlocks do: [ :bb | bb prepareWriteToStream: aStreamBuilder ].
		constantZone ifNotNil: [ constantZone prepareWriteToStream: aStreamBuilder ].
		
		aStreamBuilder label: (aStreamBuilder findSymbolForObject: self).
		instructionLowerer enterFrame.
		basicBlocks do: [ :bb | bb writeToStream: aStreamBuilder ].
		
		constantZone ifNotNil: [
			aStreamBuilder rodataSection.
			constantZone writeToStream: aStreamBuilder
		].
	]
]
