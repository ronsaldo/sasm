Class {
	#name : #SAsmFunctionPart,
	#superclass : #SAsmObject,
	#instVars : [
		'function'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #converting }
SAsmFunctionPart >> asSAsmInstructionOperand [
	^ SAsmImmediateSymbolWithAddend new
		symbol: self;
		size: function target pointerSize;
		yourself
]

{ #category : #accessing }
SAsmFunctionPart >> function [
	^ function
]

{ #category : #accessing }
SAsmFunctionPart >> function: anObject [
	function := anObject
]
