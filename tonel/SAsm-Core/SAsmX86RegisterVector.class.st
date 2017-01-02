Class {
	#name : #SAsmX86RegisterVector,
	#superclass : #SAsmX86Register,
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86RegisterVector class >> canHoldVirtualRegisterData: virtualRegister [
	^ virtualRegister isFloatRegister and: [ virtualRegister size <= 16 ]
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterVector >> isDoubleFloatRegister [
	^ true
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterVector >> isFloatRegister [
	^ true
]
