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
	^ SAsmX86RegisterAddress new base: self; size: 1
]

{ #category : #converting }
SAsmX86RegisterInt >> dword [
	^ SAsmX86RegisterAddress new base: self; size: 4
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
	^ SAsmX86RegisterAddress new base: self; size: 8
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterInt >> withSize: aSize [
	aSize = 1 ifTrue: [ ^ self byte ].
	aSize = 2 ifTrue: [ ^ self word ].
	aSize = 4 ifTrue: [ ^ self dword ].
	aSize = 8 ifTrue: [ ^ self qword ].
	self error: 'unsupported size'
	
]

{ #category : #converting }
SAsmX86RegisterInt >> word [
	^ SAsmX86RegisterAddress new base: self; size: 2
]
