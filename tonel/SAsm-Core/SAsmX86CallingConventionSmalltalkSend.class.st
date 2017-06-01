Class {
	#name : #SAsmX86CallingConventionSmalltalkSend,
	#superclass : #SAsmX86CallingConventionSmalltalk,
	#category : #'SAsm-Core-X86'
}

{ #category : #'parameter passing' }
SAsmX86CallingConventionSmalltalkSend >> integerArgumentRegisters [
	^ { self sendSelectorRegister  }
]
