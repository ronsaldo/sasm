Class {
	#name : #SAsmX86RegisterInt,
	#superclass : #SAsmX86Register,
	#category : #'SAsm-Core-X86'
}

{ #category : #converting }
SAsmX86RegisterInt >> asX86PointerOfSize: size [
	^ self asX86PointerOfSize: size vectorRegister: false
]

{ #category : #converting }
SAsmX86RegisterInt >> asX86PointerOfSize: size vectorRegister: vectorRegister [
	^ SAsmX86RegisterAddress new base: self; size: size; vectorRegister: vectorRegister
]

{ #category : #converting }
SAsmX86RegisterInt >> asX86PointerOfSize: size withBuilder: streamBuilder [
	^ self asX86PointerOfSize: size vectorRegister: false
]

{ #category : #converting }
SAsmX86RegisterInt >> byte [
	| result |
	self assert: self isByteRegister not.
	result := X86MappedRegisters at: value + 1.
	result ifNil: [ self error: 'unsupported register' ].
	^ result.
]

{ #category : #converting }
SAsmX86RegisterInt >> canBeValidByteRegisters [
	^ (X86MappedRegisters at: value + 1) isNotNil
]

{ #category : #converting }
SAsmX86RegisterInt >> dword [
	^ self isByteRegister ifTrue: [ 
		self halt.
	] ifFalse: [ 
		X86DWordRegisters at: value + 1
	]
]

{ #category : #converting }
SAsmX86RegisterInt >> isByteRegister [
	^ false
]

{ #category : #testing }
SAsmX86RegisterInt >> isIntegerRegister [
	^ true
]

{ #category : #testing }
SAsmX86RegisterInt >> isRegisterOrRegisterAddressWord [
	^ self isRegisterI8 not
]

{ #category : #testing }
SAsmX86RegisterInt >> isRegisterWord [
	^ self isRegisterI8 not
]

{ #category : #converting }
SAsmX86RegisterInt >> qword [
	^ self isByteRegister ifTrue: [ 
		self halt.
	] ifFalse: [ 
		X86QWordRegisters at: value + 1
	]
]

{ #category : #converting }
SAsmX86RegisterInt >> rexByte [
	^ X86RexByteRegisters at: value + 1
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterInt >> withSize: aSize [
	aSize = 1 ifTrue: [ ^ self rexByte ].
	aSize = 2 ifTrue: [ ^ self word ].
	aSize = 4 ifTrue: [ ^ self dword ].
	aSize = 8 ifTrue: [ ^ self qword ].
	self error: 'unsupported size'
	
]

{ #category : #converting }
SAsmX86RegisterInt >> word [
	^ self isByteRegister ifTrue: [ 
		self halt.
	] ifFalse: [ 
		X86WordRegisters at: value + 1
	]
]
