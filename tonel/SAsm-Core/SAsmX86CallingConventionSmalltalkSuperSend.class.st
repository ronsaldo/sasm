Class {
	#name : #SAsmX86CallingConventionSmalltalkSuperSend,
	#superclass : #SAsmX86CallingConventionSmalltalk,
	#category : #'SAsm-Core-X86'
}

{ #category : #'parameter passing' }
SAsmX86CallingConventionSmalltalkSuperSend >> integerArgumentRegisters [
	^ { self sendSelectorRegister . self sendLookupBehindRegister }
]
