Class {
	#name : #SAsmRegister,
	#superclass : #SAsmInstructionOperand,
	#category : #'SAsm-Core-Generic'
}

{ #category : #'as yet unclassified' }
SAsmRegister class >> canHoldVirtualRegisterData: virtualRegister [
	^ false
]

{ #category : #testing }
SAsmRegister >> isDoubleFloatRegister [
	^ false
]

{ #category : #testing }
SAsmRegister >> isFloatRegister [
	^ false
]

{ #category : #testing }
SAsmRegister >> isIntegerRegister [
	^ false
]

{ #category : #testing }
SAsmRegister >> isRegister [
	^ true
]

{ #category : #testing }
SAsmRegister >> isRegisterOrRegisterAddress [
	^ true
]
