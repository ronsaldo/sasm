Class {
	#name : #SAsmFloatVirtualRegister,
	#superclass : #SAsmVirtualRegister,
	#category : #'SAsm-Core-Generic'
}

{ #category : #testing }
SAsmFloatVirtualRegister >> isDoubleFloatOperand [
	^ size = 8
]

{ #category : #testing }
SAsmFloatVirtualRegister >> isDoubleFloatRegister [
	^ size = 8
]

{ #category : #testing }
SAsmFloatVirtualRegister >> isFloatOperand [
	^ size = 4
]

{ #category : #testing }
SAsmFloatVirtualRegister >> isFloatRegister [
	^ size = 4
]

{ #category : #testing }
SAsmFloatVirtualRegister >> isFloatingPointOperand [
	^ true
]

{ #category : #testing }
SAsmFloatVirtualRegister >> isFloatingPointRegister [
	^ true
]

{ #category : #'as yet unclassified' }
SAsmFloatVirtualRegister >> typeName [
	^ #float
]
