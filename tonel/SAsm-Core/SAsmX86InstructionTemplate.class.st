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
SAsmX86InstructionTemplate >> findBestAlternativeFor: anInstruction [
	anInstruction bestTemplateAlternative ifNotNil: [ :alt | ^ alt ].
	
	alternatives do: [ :alternative |
		(alternative canWriteInstruction: anInstruction) ifTrue: [
			anInstruction argumentsHaveFixedSize ifTrue: [
				anInstruction bestTemplateAlternative: alternative
			].
			^ alternative
		].
	].
	
	self error: 'No encoding alternative found for instruction: ' , anInstruction printString.
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionTemplate >> writeInstruction: instruction with: writer [
	(self findBestAlternativeFor: instruction) writeInstruction: instruction with: writer
]
