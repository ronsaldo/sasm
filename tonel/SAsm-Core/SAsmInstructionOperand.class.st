Class {
	#name : #SAsmInstructionOperand,
	#superclass : #SAsmObject,
	#category : #'SAsm-Core-Generic'
}

{ #category : #testing }
SAsmInstructionOperand >> isRegister [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isSymbol [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isVirtualRegister [
	^ false
]
