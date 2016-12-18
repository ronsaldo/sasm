Class {
	#name : #SAsmFunctionBuilder,
	#superclass : #Object,
	#instVars : [
		'function'
	],
	#category : #'SAsm-Core-Builder'
}

{ #category : #'as yet unclassified' }
SAsmFunctionBuilder >> basicBlock: name [
	^ function addBasicBlock: (SAsmBasicBlock new name: name).

]

{ #category : #'as yet unclassified' }
SAsmFunctionBuilder >> basicBlock: name build: aBlock [
	^ (self basicBlock: name) build: aBlock
]

{ #category : #accessing }
SAsmFunctionBuilder >> function [
	^ function
]

{ #category : #accessing }
SAsmFunctionBuilder >> function: anObject [
	function := anObject
]
