Class {
	#name : #SAsmDebugLocation,
	#superclass : #SAsmStreamElement,
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

{ #category : #accessing }
SAsmDebugLocation >> size [
	^ 0
]
