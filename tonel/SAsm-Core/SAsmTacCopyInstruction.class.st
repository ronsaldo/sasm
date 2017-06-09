Class {
	#name : #SAsmTacCopyInstruction,
	#superclass : #SAsmStreamElement,
	#instVars : [
		'source',
		'destination',
		'size',
		'alignment',
		'activeRegisters'
	],
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacCopyInstruction >> accept: aVisitor [
	^ aVisitor visitTacCopyInstruction: self
]

{ #category : #accessing }
SAsmTacCopyInstruction >> activeRegisters [
	^ activeRegisters
]

{ #category : #accessing }
SAsmTacCopyInstruction >> activeRegisters: anObject [
	activeRegisters := anObject
]

{ #category : #accessing }
SAsmTacCopyInstruction >> alignment [
	^ alignment
]

{ #category : #accessing }
SAsmTacCopyInstruction >> alignment: anObject [
	alignment := anObject
]

{ #category : #accessing }
SAsmTacCopyInstruction >> destination [
	^ destination
]

{ #category : #accessing }
SAsmTacCopyInstruction >> destination: anObject [
	destination := anObject
]

{ #category : #testing }
SAsmTacCopyInstruction >> isThreeAddressInstruction [
	^ true
]

{ #category : #accessing }
SAsmTacCopyInstruction >> markVirtualRegisterLiveAt: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex [
	source markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex.
	destination markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex.
	size markVirtualRegisterLiveRangePosition: livePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex.
]

{ #category : #testing }
SAsmTacCopyInstruction >> needsToSpillWith: instructionLowerer [
	^ true
]

{ #category : #printing }
SAsmTacCopyInstruction >> prettyPrintOn: aStream [
	aStream putKeyword: #copy; space.
	source prettyPrintOn: aStream.
	aStream putKeyword:  ' to '.
 	destination prettyPrintOn: aStream.
	aStream putKeyword: ' size '; print: size; putKeyword: ' alignment '; print: alignment
]

{ #category : #accessing }
SAsmTacCopyInstruction >> size [
	^ size
]

{ #category : #accessing }
SAsmTacCopyInstruction >> size: anObject [
	size := anObject
]

{ #category : #accessing }
SAsmTacCopyInstruction >> source [
	^ source
]

{ #category : #accessing }
SAsmTacCopyInstruction >> source: anObject [
	source := anObject
]
