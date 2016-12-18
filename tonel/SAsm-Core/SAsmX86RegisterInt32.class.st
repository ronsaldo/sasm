Class {
	#name : #SAsmX86RegisterInt32,
	#superclass : #SAsmX86RegisterInt,
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86RegisterInt32 >> isRegisterI32 [
	^ true
]

{ #category : #accessing }
SAsmX86RegisterInt32 >> size [
	^ 4
]
