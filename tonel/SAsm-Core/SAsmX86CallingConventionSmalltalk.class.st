Class {
	#name : #SAsmX86CallingConventionSmalltalk,
	#superclass : #SAsmX86CallingConventionCDecl,
	#category : #'SAsm-Core-X86'
}

{ #category : #'register ownership' }
SAsmX86CallingConventionSmalltalk >> calledRegisters [
	^ { EAX . ECX . EDX . EBX . EDI . ESI .
	XMM0 . XMM1 . XMM2 . XMM3 . XMM4 . XMM5 . XMM6 . XMM7
	}
]

{ #category : #'register ownership' }
SAsmX86CallingConventionSmalltalk >> callerRegisters [
	^ { }
]

{ #category : #testing }
SAsmX86CallingConventionSmalltalk >> hasContextMetadata [
	^ true
]

{ #category : #stack }
SAsmX86CallingConventionSmalltalk >> hasSegmentedStack [
	^ true
]

{ #category : #stack }
SAsmX86CallingConventionSmalltalk >> isStackCleanedByCaller [
	^ false
]

{ #category : #accessing }
SAsmX86CallingConventionSmalltalk >> name [
	^ #smalltalk
]

{ #category : #'return value passing' }
SAsmX86CallingConventionSmalltalk >> resultFloatRegister [
	^ XMM0
]
