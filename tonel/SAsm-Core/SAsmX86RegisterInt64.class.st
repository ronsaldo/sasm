Class {
	#name : #SAsmX86RegisterInt64,
	#superclass : #SAsmX86RegisterInt,
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86RegisterInt64 >> isRegisterI64 [
	^ true
]

{ #category : #accessing }
SAsmX86RegisterInt64 >> size [
	^ 8
]
