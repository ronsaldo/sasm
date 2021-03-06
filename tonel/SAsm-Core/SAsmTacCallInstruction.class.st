Class {
	#name : #SAsmTacCallInstruction,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'result',
		'called',
		'arguments',
		'calledConvention',
		'activeRegisters',
		'isVarArgs'
	],
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacCallInstruction >> accept: aVisitor [
	^ aVisitor visitTacCallInstruction: self
]

{ #category : #accessing }
SAsmTacCallInstruction >> activeRegisters [
	^ activeRegisters
]

{ #category : #accessing }
SAsmTacCallInstruction >> activeRegisters: anObject [
	activeRegisters := anObject
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

{ #category : #initialization }
SAsmTacCallInstruction >> initialize [
	super initialize.
	activeRegisters := #().
	isVarArgs := false.
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

{ #category : #accessing }
SAsmTacCallInstruction >> isVarArgs [
	^ isVarArgs
]

{ #category : #accessing }
SAsmTacCallInstruction >> isVarArgs: anObject [
	isVarArgs := anObject
]

{ #category : #'linear scan' }
SAsmTacCallInstruction >> markVirtualRegisterLiveAt: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex [
	called markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex.
	arguments do: [ :arg | arg markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex].
	result do: [ :res | res markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex].
]

{ #category : #testing }
SAsmTacCallInstruction >> needsToSpillWith: instructionLowerer [
	^ true
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
