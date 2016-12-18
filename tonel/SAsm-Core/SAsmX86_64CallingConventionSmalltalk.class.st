Class {
	#name : #'SAsmX86_64CallingConventionSmalltalk',
	#superclass : #'SAsmX86_64CallingConventionCDecl',
	#category : #'SAsm-Core-X86'
}

{ #category : #'register ownership' }
SAsmX86_64CallingConventionSmalltalk >> calledRegisters [
	^ { RAX . RCX . RDX . RBX. RSI . RDI . R8 . R9 . R10 . R11 . R12 . R13 . R14 . R15 .
	XMM0 . XMM1 . XMM2 . XMM3 . XMM4 . XMM5 . XMM6 . XMM7 .
	XMM8 . XMM9 . XMM10 . XMM11 . XMM11 . XMM11 . XMM11 . XMM11
	}
]

{ #category : #'register ownership' }
SAsmX86_64CallingConventionSmalltalk >> callerRegisters [
	^ { }
]

{ #category : #'parameter passing' }
SAsmX86_64CallingConventionSmalltalk >> floatArgumentRegisters [
	^ #()
]

{ #category : #stack }
SAsmX86_64CallingConventionSmalltalk >> hasContextMetadata [
	^ true
]

{ #category : #stack }
SAsmX86_64CallingConventionSmalltalk >> hasSegmentedStack [
	^ true
]

{ #category : #'parameter passing' }
SAsmX86_64CallingConventionSmalltalk >> integerArgumentRegisters [
	^ #()
]

{ #category : #stack }
SAsmX86_64CallingConventionSmalltalk >> isStackCleanedByCaller [
	^ false
]
