Class {
	#name : #SAsmX86Register,
	#superclass : #SAsmRegister,
	#instVars : [
		'name',
		'value'
	],
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86Register >> encodeModRMWithOpcode: opcode immediate: immediateSize longMode: longMod into: writer [
	| mod |
	mod := 3.
	writer nextPutC8: (mod << 6) | (opcode << 3) | self valueLow
]

{ #category : #'as yet unclassified' }
SAsmX86Register >> fullPrintOn: aStream [
	aStream putKeyword: name
]

{ #category : #testing }
SAsmX86Register >> isHighRegister [
	^ value > 7
]

{ #category : #testing }
SAsmX86Register >> isLowRegister [
	^ value <= 7
]

{ #category : #accessing }
SAsmX86Register >> name [
	^ name
]

{ #category : #accessing }
SAsmX86Register >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
SAsmX86Register >> printOn: aStream [
	aStream nextPutAll: name
]

{ #category : #accessing }
SAsmX86Register >> registerClass [
	^ self class
]

{ #category : #accessing }
SAsmX86Register >> size [
	^ self subclassResponsibility
]

{ #category : #accessing }
SAsmX86Register >> value [
	^ value
]

{ #category : #accessing }
SAsmX86Register >> value: anObject [
	value := anObject
]

{ #category : #'as yet unclassified' }
SAsmX86Register >> valueLow [
	^ value bitAnd: 7
]
