Class {
	#name : #SAsmX86RegisterInt8,
	#superclass : #SAsmX86RegisterInt,
	#category : #'SAsm-Core-X86'
}

{ #category : #converting }
SAsmX86RegisterInt8 >> byte [
	^ self
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterInt8 >> isRegisterI8 [
	^ true
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterInt8 >> isRegisterOrRegisterAddressI8 [
	^ true
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterInt8 >> size [
	^ 1
]
