Class {
	#name : #SAsmX86RegisterInt32,
	#superclass : #SAsmX86RegisterInt,
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86RegisterInt32 class >> canHoldVirtualRegisterData: virtualRegister [
	^ virtualRegister isInteger and: [virtualRegister size <= 4]
]

{ #category : #converting }
SAsmX86RegisterInt32 >> dword [
	^ self
]

{ #category : #testing }
SAsmX86RegisterInt32 >> isRegisterI32 [
	^ true
]

{ #category : #accessing }
SAsmX86RegisterInt32 >> size [
	^ 4
]
