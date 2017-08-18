Class {
	#name : #SAsmGlobalVariablePart,
	#superclass : #SAsmObject,
	#instVars : [
		'globalVariable'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #converting }
SAsmGlobalVariablePart >> asSAsmInstructionOperand [
	^ SAsmImmediateSymbolWithAddend new
		symbol: self;
		size: globalVariable target pointerSize;
		yourself
]

{ #category : #accessing }
SAsmGlobalVariablePart >> globalVariable [
	^ globalVariable
]

{ #category : #accessing }
SAsmGlobalVariablePart >> globalVariable: anObject [
	globalVariable := anObject
]
