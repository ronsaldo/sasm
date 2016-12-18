Class {
	#name : #SAsmIntegerVirtualRegister,
	#superclass : #SAsmVirtualRegister,
	#category : #'SAsm-Core-Generic'
}

{ #category : #'as yet unclassified' }
SAsmIntegerVirtualRegister >> isIntegerRegister [
	^ true
]

{ #category : #'as yet unclassified' }
SAsmIntegerVirtualRegister >> typeName [
	^ #int
]
