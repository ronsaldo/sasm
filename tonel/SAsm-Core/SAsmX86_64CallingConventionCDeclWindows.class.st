Class {
	#name : #'SAsmX86_64CallingConventionCDeclWindows',
	#superclass : #'SAsmX86_64CallingConventionCDecl',
	#category : #'SAsm-Core-X86'
}

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
