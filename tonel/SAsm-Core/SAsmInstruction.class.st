Class {
	#name : #SAsmInstruction,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'template',
		'arguments'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #visiting }
SAsmInstruction >> accept: aVisitor [
	^ aVisitor visitInstruction: self
]

{ #category : #testing }
SAsmInstruction >> isInstruction [
	^ true
]
