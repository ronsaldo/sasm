Class {
	#name : #SAsmAlignInstruction,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'alignment',
		'isCodeAlignment'
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

{ #category : #initialization }
SAsmAlignInstruction >> initialize [
	super initialize.
	alignment := 1.
	isCodeAlignment := false
]

{ #category : #testing }
SAsmAlignInstruction >> isAlignInstruction [
	^ true
]

{ #category : #accessing }
SAsmAlignInstruction >> isCodeAlignment [
	^ isCodeAlignment
]

{ #category : #accessing }
SAsmAlignInstruction >> isCodeAlignment: anObject [
	isCodeAlignment := anObject
]

{ #category : #accessing }
SAsmAlignInstruction >> size [
	^ (position alignedTo: alignment) - position
]
