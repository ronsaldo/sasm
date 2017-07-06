Class {
	#name : #SAsmFloatVirtualRegister,
	#superclass : #SAsmVirtualRegister,
	#category : #'SAsm-Core-Generic'
}

{ #category : #testing }
SAsmFloatVirtualRegister >> isDoubleFloatRegister [
	^ size = 8
]

{ #category : #testing }
SAsmFloatVirtualRegister >> isFloatRegister [
	^ size = 4
]

{ #category : #testing }
SAsmFloatVirtualRegister >> isFloatingPointRegister [
	^ true
]

{ #category : #'as yet unclassified' }
SAsmFloatVirtualRegister >> typeName [
	^ #float
]
