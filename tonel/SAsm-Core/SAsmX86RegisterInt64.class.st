Class {
	#name : #SAsmX86RegisterInt64,
	#superclass : #SAsmX86RegisterInt,
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86RegisterInt64 class >> canHoldVirtualRegisterData: virtualRegister [
	^ virtualRegister isInteger and: [virtualRegister size <= 8]
]

{ #category : #accessing }
SAsmX86RegisterInt64 >> alignment [
	^ 8
]

{ #category : #testing }
SAsmX86RegisterInt64 >> isRegisterI64 [
	^ true
]

{ #category : #converting }
SAsmX86RegisterInt64 >> qword [
	^ self
]

{ #category : #accessing }
SAsmX86RegisterInt64 >> size [
	^ 8
]
