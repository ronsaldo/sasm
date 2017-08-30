Class {
	#name : #SAsmImmediateConstant,
	#superclass : #SAsmImmediate,
	#instVars : [
		'value'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #converting }
SAsmImmediateConstant >> asSAsmConstantExpression [
	^ SAsmConstantExpressionConstantInteger new value: value; size: 4
]

{ #category : #converting }
SAsmImmediateConstant >> asX86PointerOfSize: pointerSize withBuilder: streamBuilder [
	^ SAsmX86RegisterAddress new size: pointerSize; displacement: (self copyWithStreamBuilder: streamBuilder)
]

{ #category : #testing }
SAsmImmediateConstant >> hasFixedSize [
	^ true
]

{ #category : #accessing }
SAsmImmediateConstant >> immediateValue [
	^ self value
]

{ #category : #'as yet unclassified' }
SAsmImmediateConstant >> immediateValueRelativeTo: section position: immediateWritePosition offset: relativeCheckOffset [
	^ self immediateValue - (immediateWritePosition + relativeCheckOffset)
]

{ #category : #testing }
SAsmImmediateConstant >> isImmediate32 [
	^ self isImmediateS32 or: [ self isImmediateU32 ]
]

{ #category : #testing }
SAsmImmediateConstant >> isImmediate64 [
	^ self isImmediateS64 or: [ self isImmediateU64 ]
]

{ #category : #testing }
SAsmImmediateConstant >> isImmediateConstant [
	^ true
]

{ #category : #testing }
SAsmImmediateConstant >> isImmediateS16 [
	^ value between: -16r8000 and: 16r7fff
]

{ #category : #testing }
SAsmImmediateConstant >> isImmediateS32 [
	^ value between: -16r80000000 and: 16r7fffffff
]

{ #category : #testing }
SAsmImmediateConstant >> isImmediateS64 [
	^ value between: -16r8000000000000000 and: 16r7fffffffffffffff
]

{ #category : #testing }
SAsmImmediateConstant >> isImmediateS8 [
	^ value between: -16r80 and: 16r7f
]

{ #category : #testing }
SAsmImmediateConstant >> isImmediateU16 [
	^ value between: 0 and: 16rffff
]

{ #category : #testing }
SAsmImmediateConstant >> isImmediateU32 [
	^ value between: 0 and: 16rffffffff
]

{ #category : #testing }
SAsmImmediateConstant >> isImmediateU64 [
	^ value between: 0 and: 16rffffffffffffffff
]

{ #category : #testing }
SAsmImmediateConstant >> isImmediateU8 [
	^ value between: 0 and: 16rff
]

{ #category : #accessing }
SAsmImmediateConstant >> printOn: aStream [
	aStream print: value
]

{ #category : #accessing }
SAsmImmediateConstant >> value [
	^ value
]

{ #category : #accessing }
SAsmImmediateConstant >> value: anObject [
	value := anObject
]
