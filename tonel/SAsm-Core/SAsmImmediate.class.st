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
	^ self asConstantPointerOfSize: pointerSize floatingPoint: false
]

{ #category : #converting }
SAsmImmediate >> asConstantPointerOfSize: pointerSize alignment: alignment floatingPoint: floatingPoint [
	^ SAsmConstantPointer new address: self; size: pointerSize; alignment: alignment; floatingPoint: floatingPoint
]

{ #category : #converting }
SAsmImmediate >> asConstantPointerOfSize: pointerSize floatingPoint: floatingPoint [
	^ self asConstantPointerOfSize: pointerSize alignment: pointerSize floatingPoint: floatingPoint
]

{ #category : #'as yet unclassified' }
SAsmImmediate >> immediateValueRelativeTo: section position: immediateWritePosition offset: relativeCheckOffset [
	self subclassResponsibility
]

{ #category : #testing }
SAsmImmediate >> isAtGOT [
	^ false
]

{ #category : #testing }
SAsmImmediate >> isGOTOffset [
	^ false
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

{ #category : #testing }
SAsmImmediate >> isRelativeGlobalOffsetTable [
	^ false
]

{ #category : #accessing }
SAsmImmediate >> symbol [
	^ nil
]
