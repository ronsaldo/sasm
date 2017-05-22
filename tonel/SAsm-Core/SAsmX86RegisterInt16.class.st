Class {
	#name : #SAsmX86RegisterInt16,
	#superclass : #SAsmX86RegisterInt,
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86RegisterInt16 >> isRegisterI16 [
	^ true
]

{ #category : #accessing }
SAsmX86RegisterInt16 >> size [
	^ 2
]

{ #category : #converting }
SAsmX86RegisterInt16 >> word [
	^ self
]
