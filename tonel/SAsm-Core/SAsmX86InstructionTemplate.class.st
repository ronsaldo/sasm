Class {
	#name : #SAsmX86InstructionTemplate,
	#superclass : #SAsmInstructionTemplate,
	#instVars : [
		'alternatives'
	],
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #accessing }
SAsmX86InstructionTemplate >> alternatives [
	^ alternatives
]

{ #category : #accessing }
SAsmX86InstructionTemplate >> alternatives: anObject [
	alternatives := anObject
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionTemplate >> computeMaximalSizeFor: anInstruction [
	^ (self findBestAlternativeFor: anInstruction) maxSize
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionTemplate >> findBestLongAlternativeFor: anInstruction [
	alternatives do: [ :alternative |
		(alternative canWriteLongInstruction: anInstruction) ifTrue: [
			^ alternative
		].
	].

]

{ #category : #'as yet unclassified' }
SAsmX86InstructionTemplate >> findBestShortAlternativeFor: anInstruction [
	alternatives do: [ :alternative |
		(alternative canWriteShortInstruction: anInstruction) ifTrue: [
			^ alternative
		].
	].

]

{ #category : #'as yet unclassified' }
SAsmX86InstructionTemplate >> writeInstruction: instruction with: writer [
	(self findBestAlternativeFor: instruction) writeInstruction: instruction with: writer
]
