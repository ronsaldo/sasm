Class {
	#name : #SAsmDWExpressionInstructionVariable,
	#superclass : #SAsmDWExpressionInstruction,
	#instVars : [
		'variable'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #writing }
SAsmDWExpressionInstructionVariable >> sizeWith: writer [
	| generatedVariable |
	generatedVariable := writer streamBuilder localVariableToGeneratedMap at: variable ifAbsent: [ nil ].
	generatedVariable argument ifTrue: [
		(generatedVariable offset = 0 and: [generatedVariable argumentPassingRegister isNil ]) ifTrue: [
			^ self sizeForRegister: generatedVariable argumentPassingRegister withWriter: writer
		].
		^ self sizeForFramePointerOffset: generatedVariable offset withWriter: writer
	].

	(generatedVariable offset = 0 or: [generatedVariable actuallyUsed not]) ifTrue: [ 
		^ 0
	].

	^ self sizeForFramePointerOffset: generatedVariable offset withWriter: writer

]

{ #category : #accessing }
SAsmDWExpressionInstructionVariable >> variable [
	^ variable
]

{ #category : #accessing }
SAsmDWExpressionInstructionVariable >> variable: anObject [
	variable := anObject
]

{ #category : #writing }
SAsmDWExpressionInstructionVariable >> writeWith: writer to: streamBuilder [
	| generatedVariable |
	generatedVariable := streamBuilder localVariableToGeneratedMap at: variable ifAbsent: [ nil ].
	generatedVariable argument ifTrue: [
		(generatedVariable offset = 0 and: [generatedVariable argumentPassingRegister isNil ]) ifTrue: [
			^ self writeRegister: generatedVariable argumentPassingRegister value to: streamBuilder
		].
		^ self writeFramePointerOffset: generatedVariable offset to: streamBuilder	
	].

	(generatedVariable offset = 0 or: [generatedVariable actuallyUsed not]) ifTrue: [ 
		^ self
	].
	
	^ self writeFramePointerOffset: generatedVariable offset to: streamBuilder	

]
