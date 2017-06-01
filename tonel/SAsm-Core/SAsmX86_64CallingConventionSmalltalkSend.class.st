Class {
	#name : #'SAsmX86_64CallingConventionSmalltalkSend',
	#superclass : #'SAsmX86_64CallingConventionSmalltalk',
	#category : #'SAsm-Core-X86'
}

{ #category : #'parameter passing' }
SAsmX86_64CallingConventionSmalltalkSend >> integerArgumentRegisters [
	^ { self sendSelectorRegister  }
]
