Class {
	#name : #SAsmTacJumpInstruction,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'destination'
	],
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacJumpInstruction >> accept: aVisitor [
	^ aVisitor visitTacJumpInstruction: self
]

{ #category : #accessing }
SAsmTacJumpInstruction >> destination [
	^ destination
]

{ #category : #accessing }
SAsmTacJumpInstruction >> destination: anObject [
	destination := anObject
]

{ #category : #testing }
SAsmTacJumpInstruction >> isThreeAddressInstruction [
	^ true
]

{ #category : #printing }
SAsmTacJumpInstruction >> prettyPrintOn: aStream [
	aStream putKeyword: #jump; space.
	destination prettyPrintOn: aStream.

]

{ #category : #printing }
SAsmTacJumpInstruction >> printOn: aStream [
	aStream nextPutAll: #jump; space.
	destination printOn: aStream.

]
