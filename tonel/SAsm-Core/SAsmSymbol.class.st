Class {
	#name : #SAsmSymbol,
	#superclass : #SAsmObject,
	#traits : 'TSAsmVisibility',
	#classTraits : 'TSAsmVisibility classTrait',
	#instVars : [
		'name',
		'visibility',
		'type',
		'section',
		'value',
		'size'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #converting }
SAsmSymbol >> asConstantPointerOfSize: pointerSize [
	^ self asConstantPointerOfSize: pointerSize floatingPoint: false
]

{ #category : #converting }
SAsmSymbol >> asConstantPointerOfSize: pointerSize floatingPoint: floatingPoint [
	^ (self immediate: pointerSize) asConstantPointerOfSize: pointerSize floatingPoint: floatingPoint
]

{ #category : #converting }
SAsmSymbol >> asSAsmInstructionOperand [
	^ self immediate: 0
]

{ #category : #immediates }
SAsmSymbol >> byte [
	^ self immediate: 1
]

{ #category : #immediates }
SAsmSymbol >> dword [
	^ self immediate: 4
]

{ #category : #immediates }
SAsmSymbol >> immediate: immediateSize [
	^ SAsmImmediateSymbolWithAddend new
		symbol: self;
		size: immediateSize;
		yourself
]

{ #category : #immediates }
SAsmSymbol >> immediateSectionRelative: immediateSize [
	^ SAsmImmediateSymbolWithAddend new
		symbol: self;
		size: immediateSize;
		sectionRelative: true;
		yourself
]

{ #category : #accessing }
SAsmSymbol >> immediateValue [
	^ 0
]

{ #category : #'as yet unclassified' }
SAsmSymbol >> initialize [
	super initialize.
	type := #unknown.
	size := 0.
]

{ #category : #testing }
SAsmSymbol >> isSAsmSymbol [
	^ true
]

{ #category : #testing }
SAsmSymbol >> isUndefined [
	^ section isNil or: [ value isNil ]
]

{ #category : #accessing }
SAsmSymbol >> name [
	^ name
]

{ #category : #accessing }
SAsmSymbol >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
SAsmSymbol >> positionValue [
	^ value
]

{ #category : #accessing }
SAsmSymbol >> prettyPrintOn: aStream [
	aStream putIdentifier: self visibilityPrefix; putIdentifier: self validName
]

{ #category : #accessing }
SAsmSymbol >> printOn: aStream [
	aStream nextPutAll: self visibilityPrefix; nextPutAll: self validName
]

{ #category : #immediates }
SAsmSymbol >> qword [
	^ self immediate: 8
]

{ #category : #accessing }
SAsmSymbol >> section [
	^ section
]

{ #category : #accessing }
SAsmSymbol >> section: anObject [
	section := anObject
]

{ #category : #accessing }
SAsmSymbol >> sectionName [
	section ifNil: [ ^ nil ].
	^ section name
]

{ #category : #testing }
SAsmSymbol >> shouldBeKeep [
	^ self isPrivate not
]

{ #category : #accessing }
SAsmSymbol >> size [
	^ size
]

{ #category : #accessing }
SAsmSymbol >> size: anObject [
	size := anObject
]

{ #category : #accessing }
SAsmSymbol >> type [
	^ type
]

{ #category : #accessing }
SAsmSymbol >> type: anObject [
	type := anObject
]

{ #category : #accessing }
SAsmSymbol >> validName [
	^ name ifNil: [ #anonsymbol ]
]

{ #category : #accessing }
SAsmSymbol >> value [
	^ value
]

{ #category : #accessing }
SAsmSymbol >> value: anObject [
	value := anObject
]

{ #category : #accessing }
SAsmSymbol >> visibility [
	^ visibility
]

{ #category : #accessing }
SAsmSymbol >> visibility: anObject [
	visibility := anObject
]

{ #category : #accessing }
SAsmSymbol >> visibilityPrefix [
	self isPrivate ifTrue: [ ^'.L' ].
	^ ''
]

{ #category : #immediates }
SAsmSymbol >> word [
	^ self immediate: 2
]
