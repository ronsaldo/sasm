Class {
	#name : #SAsmX86RegisterInt,
	#superclass : #SAsmX86Register,
	#category : #'SAsm-Core-X86'
}

{ #category : #converting }
SAsmX86RegisterInt >> asPointer [
	^ SAsmX86RegisterAddress new base: self; size: self size
]

{ #category : #converting }
SAsmX86RegisterInt >> asPointerOfSize: size [
	^ SAsmX86RegisterAddress new base: self; size: size
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

{ #category : #converting }
SAsmX86RegisterInt >> word [
	^ SAsmX86RegisterAddress new base: self; size: 2
]
