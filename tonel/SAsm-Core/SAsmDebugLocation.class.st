Class {
	#name : #SAsmDebugLocation,
	#superclass : #SAsmDebugInstruction,
	#instVars : [
		'data'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #accessing }
SAsmDebugLocation >> accept: aVisitor [
	^ aVisitor visitDebugSourceLocation: self
]

{ #category : #accessing }
SAsmDebugLocation >> data [
	^ data
]

{ #category : #accessing }
SAsmDebugLocation >> data: anObject [
	data := anObject
]

{ #category : #printing }
SAsmDebugLocation >> fullPrintOn: aStream [
	aStream putKeyword: 'loc '; print: data
]

{ #category : #accessing }
SAsmDebugLocation >> size [
	^ 0
]
