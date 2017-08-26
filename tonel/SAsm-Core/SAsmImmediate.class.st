Class {
	#name : #SAsmImmediate,
	#superclass : #SAsmInstructionOperand,
	#classVars : [
		'PrivateVisibility'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #accessing }
SAsmImmediate >> addend [
	^ 0
]

{ #category : #converting }
SAsmImmediate >> asConstantPointerOfSize: pointerSize [
	^ SAsmConstantPointer new address: self; size: pointerSize 
]

{ #category : #'as yet unclassified' }
SAsmImmediate >> immediateValueRelativeTo: section position: immediateWritePosition offset: relativeCheckOffset [
	self subclassResponsibility
]

{ #category : #testing }
SAsmImmediate >> isImmediate [
	^ true
]

{ #category : #testing }
SAsmImmediate >> isImmediateS8RelativeTo: anInstruction position: immediateWritePosition offset: relativeCheck [
	| relValue |
	anInstruction section ifNil: [ ^ false ].
	relValue := self immediateValueRelativeTo: anInstruction section position: immediateWritePosition offset: relativeCheck.
	^ relValue between: -128 and: 127
	
]

{ #category : #accessing }
SAsmImmediate >> symbol [
	^ nil
]
