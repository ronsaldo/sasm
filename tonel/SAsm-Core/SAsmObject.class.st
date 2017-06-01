Class {
	#name : #SAsmObject,
	#superclass : #Object,
	#classVars : [
		'DllExportVisibility',
		'DllImportVisibility',
		'ExternalVisibility',
		'PrivateVisibility',
		'WeakVisibility'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'class initialization' }
SAsmObject class >> initialize [
	super initialize.
	PrivateVisibility := #private.
	DllExportVisibility := #dllexport.
	DllImportVisibility := #dllimport.
	WeakVisibility := #weak.
	ExternalVisibility := #external.
]

{ #category : #printing }
SAsmObject >> fullPrintOn: aStream [
	self prettyPrintOn: aStream
]

{ #category : #printing }
SAsmObject >> fullPrintString [
	^ SAsmPrintingStream fullPrintString: self
]

{ #category : #printing }
SAsmObject >> fullPrintText [
	^ SAsmPrintingTextStream fullPrintString: self
]

{ #category : #testing }
SAsmObject >> isInstructionOperand [
	^ false
]

{ #category : #testing }
SAsmObject >> isSAsmConstantExpression [
	^ false
]

{ #category : #testing }
SAsmObject >> isSAsmSymbol [
	^ false
]

{ #category : #testing }
SAsmObject >> isVirtualRegister [
	^ false
]

{ #category : #printing }
SAsmObject >> prettyPrintOn: aStream [
	self printOn: aStream
]
