Class {
	#name : #SAsmImmediate,
	#superclass : #SAsmInstructionOperand,
	#instVars : [
		'value'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'as yet unclassified' }
SAsmImmediate >> immediateValue [
	^ self value
]

{ #category : #'as yet unclassified' }
SAsmImmediate >> isImmediate [
	^ true
]

{ #category : #'as yet unclassified' }
SAsmImmediate >> isImmediate32 [
	^ self isImmediateS32 or: [ self isImmediateU32 ]
]

{ #category : #'as yet unclassified' }
SAsmImmediate >> isImmediate64 [
	^ self isImmediateS64 or: [ self isImmediateU64 ]
]

{ #category : #'as yet unclassified' }
SAsmImmediate >> isImmediateS16 [
	^ value between: -16r8000 and: 16r7fff
]

{ #category : #'as yet unclassified' }
SAsmImmediate >> isImmediateS32 [
	^ value between: -16r80000000 and: 16r7fffffff
]

{ #category : #'as yet unclassified' }
SAsmImmediate >> isImmediateS64 [
	^ value between: -16r8000000000000000 and: 16r7fffffffffffffff
]

{ #category : #'as yet unclassified' }
SAsmImmediate >> isImmediateS8 [
	^ value between: -16r80 and: 16r7f
]

{ #category : #'as yet unclassified' }
SAsmImmediate >> isImmediateU16 [
	^ value between: 0 and: 16rffff
]

{ #category : #'as yet unclassified' }
SAsmImmediate >> isImmediateU32 [
	^ value between: 0 and: 16rffffffff
]

{ #category : #'as yet unclassified' }
SAsmImmediate >> isImmediateU64 [
	^ value between: 0 and: 16rffffffffffffffff
]

{ #category : #'as yet unclassified' }
SAsmImmediate >> isImmediateU8 [
	^ value between: 0 and: 16rff
]

{ #category : #accessing }
SAsmImmediate >> printOn: aStream [
	aStream print: value
]

{ #category : #accessing }
SAsmImmediate >> value [
	^ value
]

{ #category : #accessing }
SAsmImmediate >> value: anObject [
	value := anObject
]
