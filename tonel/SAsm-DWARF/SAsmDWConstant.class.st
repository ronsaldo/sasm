Class {
	#name : #SAsmDWConstant,
	#superclass : #SAsmConstantExpressionConstantInteger,
	#instVars : [
		'name'
	],
	#pools : [
		'SAsmDWConstants'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #comparing }
SAsmDWConstant >> = other [
	^ value = other value
]

{ #category : #'as yet unclassified' }
SAsmDWConstant >> hash [
	^ value hash
]

{ #category : #accessing }
SAsmDWConstant >> name [
	^ name
]

{ #category : #accessing }
SAsmDWConstant >> name: anObject [
	name := anObject
]

{ #category : #printing }
SAsmDWConstant >> printOn: aStream [
	aStream nextPutAll: name
]
