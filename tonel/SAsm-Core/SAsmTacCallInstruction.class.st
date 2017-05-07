Class {
	#name : #SAsmTacCallInstruction,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'result',
		'called',
		'arguments',
		'calledConvention'
	],
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacCallInstruction >> accept: aVisitor [
	^ aVisitor visitTacCallInstruction: self
]

{ #category : #accessing }
SAsmTacCallInstruction >> arguments [
	^ arguments
]

{ #category : #accessing }
SAsmTacCallInstruction >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
SAsmTacCallInstruction >> called [
	^ called
]

{ #category : #accessing }
SAsmTacCallInstruction >> called: anObject [
	called := anObject
]

{ #category : #accessing }
SAsmTacCallInstruction >> calledConvention [
	^ calledConvention
]

{ #category : #accessing }
SAsmTacCallInstruction >> calledConvention: anObject [
	calledConvention := anObject
]

{ #category : #testing }
SAsmTacCallInstruction >> isCallInstruction [
	^ true
]

{ #category : #testing }
SAsmTacCallInstruction >> isCondition [
	^ false
]

{ #category : #testing }
SAsmTacCallInstruction >> isThreeAddressInstruction [
	^ true
]

{ #category : #'linear scan' }
SAsmTacCallInstruction >> markVirtualRegisterLiveRanges [
	called markVirtualRegisterLiveRangePosition: index.
	arguments do: [ :arg | arg markVirtualRegisterLiveRangePosition: index ].
	result do: [ :res | res markVirtualRegisterLiveRangePosition: index ].
]

{ #category : #printing }
SAsmTacCallInstruction >> prettyPrintOn: aStream [
	result do: [ :el | el prettyPrintOn: aStream. aStream space ].
	aStream nextPutAll: ':= '.
	aStream putKeyword: #call; space; putKeyword: calledConvention name; space.
	called prettyPrintOn: aStream.
	arguments do: [ :arg | aStream space. arg prettyPrintOn: aStream ]
]

{ #category : #accessing }
SAsmTacCallInstruction >> result [
	^ result
]

{ #category : #accessing }
SAsmTacCallInstruction >> result: anObject [
	result := anObject
]
