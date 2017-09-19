Class {
	#name : #SAsmModule,
	#superclass : #SAsmObject,
	#instVars : [
		'elements',
		'target'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #construction }
SAsmModule class >> x86 [
	^ self new target: SAsmCompilationTargetX86 new
]

{ #category : #construction }
SAsmModule class >> x86_64 [
	^ self new target: SAsmCompilationTargetX86_64 new
]

{ #category : #adding }
SAsmModule >> addElement: anElement [
	elements add: anElement.
	^ anElement

]

{ #category : #adding }
SAsmModule >> addElements: newElements [
	elements addAll: newElements

]

{ #category : #converting }
SAsmModule >> asBinaryObject [
	^ self asInstructionStream asBinaryObject
]

{ #category : #converting }
SAsmModule >> asInstructionStream [
	| result |
	result := SAsmStream new target: target.

	result build: [ :streamBuilder |
		elements do: [ :element | element prepareWriteToStream: streamBuilder ].
		elements reject: #isLastElement thenDo: [ :element | element writeToStream: streamBuilder ].
		elements select: #isLastElement thenDo: [ :element | element writeToStream: streamBuilder ].
	].	
	^ result
]

{ #category : #converting }
SAsmModule >> asOptimizedBinaryObject [
	^ self asInstructionStream optimize asBinaryObject
]

{ #category : #converting }
SAsmModule >> asOptimizedInstructionStream [
	^ self asInstructionStream optimize
]

{ #category : #building }
SAsmModule >> build: functionName function: aBlock [
	| function |
	function := SAsmFunction new name: functionName; target: target; yourself.
	self addElement: function.
	^ function build: aBlock
]

{ #category : #building }
SAsmModule >> buildFunction: aBlock [
	^ self build: nil function: aBlock
]

{ #category : #'as yet unclassified' }
SAsmModule >> createDummyFunction [
	| function |
	function := SAsmFunction new target: target; callingConventionNamed: #naked.
	function addBasicBlock: (SAsmBasicBlock new name: #dummy).
	^ self addElement: function
]

{ #category : #accessing }
SAsmModule >> elements [
	^ elements
]

{ #category : #printing }
SAsmModule >> fullPrintOn: aStream [
	elements do: [ :element | element fullPrintOn: aStream ]
]

{ #category : #accessing }
SAsmModule >> globalNamed: aName [
	elements do: [ :element | element name = aName ifTrue: [ ^ element ] ].
	^ nil
]

{ #category : #'gt-inspector-extension' }
SAsmModule >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ elements gtInspectorItemsIn: composite
]

{ #category : #'gt-inspector-extension' }
SAsmModule >> gtInspectorMachineCode: composite [
	"<gtInspectorPresentationOrder: 4>
	^ (composite wrapper)
		title: 'Machine Code';
		show: [ :a | self asBinaryObject sections gtInspectorItemsIn: a ]"
]

{ #category : #'gt-inspector-extension' }
SAsmModule >> gtInspectorModuleText: composite [
	<gtInspectorPresentationOrder: 1>
	^ (composite text)
		title: 'Assembly Module';
		format: #fullPrintText
]

{ #category : #'gt-inspector-extension' }
SAsmModule >> gtInspectorOptimizerStreamText: composite [
	<gtInspectorPresentationOrder: 3>
	^ (composite text)
		title: 'Optimized Assembly';
		display: [ :el | el asOptimizedInstructionStream ];
		format: #fullPrintText
]

{ #category : #'gt-inspector-extension' }
SAsmModule >> gtInspectorStreamText: composite [
	<gtInspectorPresentationOrder: 2>
	^ (composite text)
		title: 'Assembly';
		display: [ :el | el asInstructionStream ];
		format: #fullPrintText
]

{ #category : #initialization }
SAsmModule >> initialize [
	super initialize.
	elements := OrderedCollection new.
	target := SAsmCompilationTargetX86 new.
]

{ #category : #accessing }
SAsmModule >> target [
	^ target
]

{ #category : #accessing }
SAsmModule >> target: anObject [
	target := anObject
]
