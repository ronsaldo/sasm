Class {
	#name : #SAsmFunctionBuilder,
	#superclass : #Object,
	#instVars : [
		'function'
	],
	#category : #'SAsm-Core-Builder'
}

{ #category : #'calling conventions' }
SAsmFunctionBuilder >> apicall [
	function apicall
]

{ #category : #'as yet unclassified' }
SAsmFunctionBuilder >> basicBlock: name [
	^ function addBasicBlock: (SAsmBasicBlock new name: name).

]

{ #category : #'as yet unclassified' }
SAsmFunctionBuilder >> basicBlock: name build: aBlock [
	^ (self basicBlock: name) build: aBlock
]

{ #category : #'calling conventions' }
SAsmFunctionBuilder >> cdecl [
	function cdecl
]

{ #category : #accessing }
SAsmFunctionBuilder >> function [
	^ function
]

{ #category : #accessing }
SAsmFunctionBuilder >> function: anObject [
	function := anObject
]

{ #category : #'calling conventions' }
SAsmFunctionBuilder >> naked [
	function naked
]

{ #category : #'calling conventions' }
SAsmFunctionBuilder >> smalltalk [
	function smalltalk
]

{ #category : #'calling conventions' }
SAsmFunctionBuilder >> stdcall [
	function stdcall
]
