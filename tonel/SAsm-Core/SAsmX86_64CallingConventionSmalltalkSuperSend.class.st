Class {
	#name : #'SAsmX86_64CallingConventionSmalltalkSuperSend',
	#superclass : #'SAsmX86_64CallingConventionSmalltalk',
	#category : #'SAsm-Core-X86'
}

{ #category : #'parameter passing' }
SAsmX86_64CallingConventionSmalltalkSuperSend >> integerArgumentRegisters [
	^ { self sendSelectorRegister . self sendLookupBehindRegister }
]
