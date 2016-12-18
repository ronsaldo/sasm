Class {
	#name : #SAsmModule,
	#superclass : #SAsmObject,
	#instVars : [
		'elements'
	],
	#category : #'SAsm-Core-Generic'
}

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
	result := SAsmStream new.
	result build: [ :streamBuilder |
		elements do: [ :element | element writeToStream: streamBuilder ].
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
	function := SAsmFunction new name: functionName.
	self addElement: function.
	^ function build: aBlock
]

{ #category : #building }
SAsmModule >> buildFunction: aBlock [
	^ self build: nil function: aBlock
]

{ #category : #accessing }
SAsmModule >> elements [
	^ elements
]

{ #category : #printing }
SAsmModule >> fullPrintOn: aStream [
	elements do: [ :element | element fullPrintOn: aStream ]
]

{ #category : #'gt-inspector-extension' }
SAsmModule >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ elements gtInspectorItemsIn: composite
]

{ #category : #'gt-inspector-extension' }
SAsmModule >> gtInspectorMachineCode: composite [
	<gtInspectorPresentationOrder: 4>
	^ (composite wrapper)
		title: 'Machine Code';
		show: [ :a | self asBinaryObject sections gtInspectorItemsIn: a ]
]

{ #category : #'gt-inspector-extension' }
SAsmModule >> gtInspectorModuleText: composite [
	<gtInspectorPresentationOrder: 0>  
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
]
