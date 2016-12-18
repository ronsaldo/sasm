Class {
	#name : #SAsmRegister,
	#superclass : #SAsmInstructionOperand,
	#category : #'SAsm-Core-Generic'
}

{ #category : #testing }
SAsmRegister >> isRegister [
	^ true
]

{ #category : #testing }
SAsmRegister >> isRegisterOrRegisterAddress [
	^ true
]
