Class {
	#name : #SAsmDWBuilder,
	#superclass : #SAsmDWObject,
	#instVars : [
		'currentNode'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #tags }
SAsmDWBuilder >> arrayType: aBlock [
	^ self newDebugInfoEntry: DW_TAG_array_type build: aBlock
]

{ #category : #tags }
SAsmDWBuilder >> baseType: aBlock [
	^ self newDebugInfoEntry: DW_TAG_base_type build: aBlock
]

{ #category : #tags }
SAsmDWBuilder >> compileUnit: aBlock [
	^ self newDebugInfoEntry: DW_TAG_compile_unit build: aBlock
]

{ #category : #tags }
SAsmDWBuilder >> constType: aBlock [
	^ self newDebugInfoEntry: DW_TAG_const_type build: aBlock
]

{ #category : #accessing }
SAsmDWBuilder >> currentNode [
	^ currentNode
]

{ #category : #accessing }
SAsmDWBuilder >> currentNode: anObject [
	^ currentNode := anObject
]

{ #category : #tags }
SAsmDWBuilder >> formalParameter: aBlock [
	^ self newDebugInfoEntry: DW_TAG_formal_parameter build: aBlock
]

{ #category : #accessing }
SAsmDWBuilder >> member: aBlock [
	^ self newDebugInfoEntry: DW_TAG_member build: aBlock
]

{ #category : #'instance creation' }
SAsmDWBuilder >> newDebugInfoEntry: tag [
	| result |
	result := SAsmDWDebugInfoEntry new tag: tag.
	currentNode ifNotNil: [ currentNode addChild: result ].
	^ result
]

{ #category : #'instance creation' }
SAsmDWBuilder >> newDebugInfoEntry: tag build: aBlock [
	| result oldNode |
	result := self newDebugInfoEntry: tag.
	oldNode := currentNode.
	currentNode := result.
	[
		aBlock cull: result cull: self.
	] ensure: [ currentNode := oldNode ].

	^ result
]

{ #category : #tags }
SAsmDWBuilder >> pointerType: aBlock [
	^ self newDebugInfoEntry: DW_TAG_pointer_type build: aBlock
]

{ #category : #tags }
SAsmDWBuilder >> structureType: aBlock [
	^ self newDebugInfoEntry: DW_TAG_structure_type build: aBlock
]

{ #category : #tags }
SAsmDWBuilder >> subprogram: aBlock [
	^ self newDebugInfoEntry: DW_TAG_subprogram build: aBlock
]

{ #category : #tags }
SAsmDWBuilder >> subrangeType: aBlock [
	^ self newDebugInfoEntry: DW_TAG_subrange_type build: aBlock
]

{ #category : #tags }
SAsmDWBuilder >> typedef: aBlock [
	^ self newDebugInfoEntry: DW_TAG_typedef build: aBlock
]

{ #category : #tags }
SAsmDWBuilder >> variable: aBlock [
	^ self newDebugInfoEntry: DW_TAG_variable build: aBlock
]
