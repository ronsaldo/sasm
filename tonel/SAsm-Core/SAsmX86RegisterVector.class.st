Class {
	#name : #SAsmX86RegisterVector,
	#superclass : #SAsmX86Register,
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86RegisterVector class >> canHoldVirtualRegisterData: virtualRegister [
	^ virtualRegister isFloatingPointOperand and: [ virtualRegister size <= 16 ]
]

{ #category : #testing }
SAsmX86RegisterVector >> isDoubleFloatOperand [
	^ true
]

{ #category : #testing }
SAsmX86RegisterVector >> isDoubleFloatRegister [
	^ true
]

{ #category : #testing }
SAsmX86RegisterVector >> isFloatOperand [
	^ true
]

{ #category : #testing }
SAsmX86RegisterVector >> isFloatRegister [
	^ true
]

{ #category : #testing }
SAsmX86RegisterVector >> isFloatingPointOperand [
	^ true
]

{ #category : #testing }
SAsmX86RegisterVector >> isFloatingPointRegister [
	^ true
]

{ #category : #testing }
SAsmX86RegisterVector >> isRegisterOrRegisterAddressVector128 [
	^ true
]

{ #category : #testing }
SAsmX86RegisterVector >> isRegisterVector128 [
	^ true
]

{ #category : #testing }
SAsmX86RegisterVector >> isVectorRegister [
	^ true
]
