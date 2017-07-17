Class {
	#name : #SAsmX86RegisterInt8,
	#superclass : #SAsmX86RegisterInt,
	#category : #'SAsm-Core-X86'
}

{ #category : #accessing }
SAsmX86RegisterInt8 >> alignment [
	^ 1
]

{ #category : #converting }
SAsmX86RegisterInt8 >> byte [
	^ self
]

{ #category : #testing }
SAsmX86RegisterInt8 >> canBeValidByteRegisters [
	^ true
]

{ #category : #testing }
SAsmX86RegisterInt8 >> isByteRegister [
	^ true
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterInt8 >> isRegisterI8 [
	^ true
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterInt8 >> isRegisterOrRegisterAddressI8 [
	^ true
]

{ #category : #converting }
SAsmX86RegisterInt8 >> rexByte [
	^ self
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterInt8 >> size [
	^ 1
]
