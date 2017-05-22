Class {
	#name : #SAsmAlignInstruction,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'alignment'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #visiting }
SAsmAlignInstruction >> accept: aVisitor [
	^ aVisitor visitAlignInstruction: self
]

{ #category : #accessing }
SAsmAlignInstruction >> alignment [
	^ alignment
]

{ #category : #accessing }
SAsmAlignInstruction >> alignment: anObject [
	alignment := anObject
]

{ #category : #printing }
SAsmAlignInstruction >> fullPrintOn: aStream [
	aStream putKeyword: 'align '; print: alignment
]

{ #category : #testing }
SAsmAlignInstruction >> isAlignInstruction [
	^ true
]

{ #category : #accessing }
SAsmAlignInstruction >> size [
	^ (position alignedTo: alignment) - position
]
