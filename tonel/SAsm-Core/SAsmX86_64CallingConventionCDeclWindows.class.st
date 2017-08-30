Class {
	#name : #'SAsmX86_64CallingConventionCDeclWindows',
	#superclass : #'SAsmX86_64CallingConventionCDecl',
	#category : #'SAsm-Core-X86'
}

{ #category : #'register ownership' }
SAsmX86_64CallingConventionCDeclWindows >> calledRegisters [
	^ { RAX . RCX . RDX . R8 . R9 . R10 . R11 .
	XMM0 . XMM1 . XMM2 . XMM3 . XMM4 . XMM5 .
	XMM8 . XMM9 . XMM10 . XMM11 . XMM11 . XMM11 . XMM11 . XMM11}
]

{ #category : #'register ownership' }
SAsmX86_64CallingConventionCDeclWindows >> callerRegisters [
	^ { RBX . RDI . RSI . R12 . R13 . R14 . R15 .
		XMM6 . XMM7 }
]

{ #category : #'parameter passing' }
SAsmX86_64CallingConventionCDeclWindows >> floatArgumentRegisters [
	^ { XMM0 . XMM1 . XMM2 . XMM3 }
]

{ #category : #'parameter passing' }
SAsmX86_64CallingConventionCDeclWindows >> integerArgumentRegisters [
	^ { RCX . RDX . R8 . R9 }
]

{ #category : #accessing }
SAsmX86_64CallingConventionCDeclWindows >> name [
	^ #cdecl_win64
]

{ #category : #'default abi' }
SAsmX86_64CallingConventionCDeclWindows >> shadowCallSpaceSize [
	^ 32
]

{ #category : #'as yet unclassified' }
SAsmX86_64CallingConventionCDeclWindows >> variadicVectorCountRegister [
	^ nil
]
