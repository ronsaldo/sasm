Class {
	#name : #SAsmTacReturnFromFrame,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'newFrame',
		'exitPoint',
		'returnValues',
		'activeRegisters'
	],
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacReturnFromFrame >> accept: aVisitor [
	^ aVisitor visitTacReturnFromFrame: self
]

{ #category : #accessing }
SAsmTacReturnFromFrame >> activeRegisters [
	^ activeRegisters
]

{ #category : #accessing }
SAsmTacReturnFromFrame >> activeRegisters: anObject [
	activeRegisters := anObject
]

{ #category : #accessing }
SAsmTacReturnFromFrame >> exitPoint [
	^ exitPoint
]

{ #category : #accessing }
SAsmTacReturnFromFrame >> exitPoint: anObject [
	exitPoint := anObject
]

{ #category : #initialization }
SAsmTacReturnFromFrame >> initialize [
	super initialize.
	activeRegisters := #()
]

{ #category : #visiting }
SAsmTacReturnFromFrame >> isThreeAddressInstruction [
	^ true
]

{ #category : #visiting }
SAsmTacReturnFromFrame >> markVirtualRegisterLiveAt: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex [
	newFrame markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex.
	exitPoint markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex.
	returnValues do: [ :val | val markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex].
]

{ #category : #visiting }
SAsmTacReturnFromFrame >> needsToSpillWith: instructionLowerer [
	^ instructionLowerer needsToSpillReturnFromFrame: self
]

{ #category : #accessing }
SAsmTacReturnFromFrame >> newFrame [
	^ newFrame
]

{ #category : #accessing }
SAsmTacReturnFromFrame >> newFrame: anObject [
	newFrame := anObject
]

{ #category : #accessing }
SAsmTacReturnFromFrame >> returnValues [
	^ returnValues
]

{ #category : #accessing }
SAsmTacReturnFromFrame >> returnValues: anObject [
	returnValues := anObject
]
