Class {
	#name : #'SAsmX86_64CallingConventionCDecl',
	#superclass : #'SAsmX86_64CallingConvention',
	#category : #'SAsm-Core-X86'
}

{ #category : #'register ownership' }
SAsmX86_64CallingConventionCDecl >> calledRegisters [
	^ { RAX . RCX . RDX . RSI . RDI . R8 . R9 . R10 . R11 .
	XMM0 . XMM1 . XMM2 . XMM3 . XMM4 . XMM5 . XMM6 . XMM7 .
	XMM8 . XMM9 . XMM10 . XMM11 . XMM11 . XMM11 . XMM11 . XMM11
	}
]

{ #category : #'register ownership' }
SAsmX86_64CallingConventionCDecl >> callerRegisters [
	^ { RBX . R12 . R13 . R14 . R15 }
]

{ #category : #stack }
SAsmX86_64CallingConventionCDecl >> canBeFrameLess [
	^ true
]

{ #category : #'parameter passing' }
SAsmX86_64CallingConventionCDecl >> floatArgumentRegisters [
	^ { XMM0 . XMM1 . XMM2 . XMM3 . XMM4 . XMM5 . XMM6 }
]

{ #category : #'parameter passing' }
SAsmX86_64CallingConventionCDecl >> integerArgumentRegisters [
	^ { RDI . RSI . RDX . RCX . R8 . R9 }
]

{ #category : #stack }
SAsmX86_64CallingConventionCDecl >> isStackCleanedByCaller [
	^ true
]

{ #category : #accessing }
SAsmX86_64CallingConventionCDecl >> name [
	^ #cdecl
]

{ #category : #'return value passing' }
SAsmX86_64CallingConventionCDecl >> resultFloatRegister [
	^ XMM0
]

{ #category : #'return value passing' }
SAsmX86_64CallingConventionCDecl >> resultInt2Register [
	^ RCX
]

{ #category : #'return value passing' }
SAsmX86_64CallingConventionCDecl >> resultIntRegister [
	^ RAX
]

{ #category : #'register allocation' }
SAsmX86_64CallingConventionCDecl >> scratchRegisters [
	^ {
	RAX . RCX .
	XMM0 . XMM1 .
	}
]

{ #category : #'message passing' }
SAsmX86_64CallingConventionCDecl >> sendDescriptionRegister [
	^ RCX
]

{ #category : #'message passing' }
SAsmX86_64CallingConventionCDecl >> sendLookupBehindRegister [
	^ RDX
]

{ #category : #'message passing' }
SAsmX86_64CallingConventionCDecl >> sendSelectorRegister [
	^ RAX
]

{ #category : #stack }
SAsmX86_64CallingConventionCDecl >> stackAlignment [
	^ 16
]

{ #category : #stack }
SAsmX86_64CallingConventionCDecl >> stackArgumentAlignment [
	^ 8
]

{ #category : #'register allocation' }
SAsmX86_64CallingConventionCDecl >> usableRegisters [
	^ {
	RAX . RCX . RDX . RBX. RSI . RDI . R8 . R9 . R10 . R11 . R12 . R13 . R14 . R15 .
	XMM0 . XMM1 . XMM2 . XMM3 . XMM4 . XMM5 . XMM6 . XMM7 .
	XMM8 . XMM9 . XMM10 . XMM11 . XMM12 . XMM13 . XMM14 . XMM15 .
	}
]

{ #category : #'as yet unclassified' }
SAsmX86_64CallingConventionCDecl >> variadicVectorCountRegister [
	^ RAX
]
