Class {
	#name : #SAsmX86CallingConventionCDecl,
	#superclass : #SAsmX86CallingConvention,
	#category : #'SAsm-Core-X86'
}

{ #category : #'register ownership' }
SAsmX86CallingConventionCDecl >> calledRegisters [
	^ { EAX . ECX . EDX .
	XMM0 . XMM1 . XMM2 . XMM3 . XMM4 . XMM5 . XMM6 . XMM7
	}
]

{ #category : #'register ownership' }
SAsmX86CallingConventionCDecl >> callerRegisters [
	^ { EBX . EDI . ESI }
]

{ #category : #stack }
SAsmX86CallingConventionCDecl >> canBeFrameLess [
	^ true
]

{ #category : #'parameter passing' }
SAsmX86CallingConventionCDecl >> gotRegister [
	^ EBX
]

{ #category : #testing }
SAsmX86CallingConventionCDecl >> hasContextMetadata [
	^ false
]

{ #category : #stack }
SAsmX86CallingConventionCDecl >> isStackCleanedByCaller [
	^ true
]

{ #category : #accessing }
SAsmX86CallingConventionCDecl >> name [
	^ #cdecl
]

{ #category : #'return value passing' }
SAsmX86CallingConventionCDecl >> resultFloatRegister [
	^ nil
]

{ #category : #'return value passing' }
SAsmX86CallingConventionCDecl >> resultInt2Register [
	^ ECX
]

{ #category : #'return value passing' }
SAsmX86CallingConventionCDecl >> resultIntRegister [
	^ EAX
]

{ #category : #'register allocation' }
SAsmX86CallingConventionCDecl >> scratchRegisters [
	^ {
	EAX . ECX .
	XMM0 . XMM1 .
	}
]

{ #category : #'as yet unclassified' }
SAsmX86CallingConventionCDecl >> sendDescriptionRegister [
	^ ECX
]

{ #category : #'as yet unclassified' }
SAsmX86CallingConventionCDecl >> sendLookupBehindRegister [
	^ EDX
]

{ #category : #'as yet unclassified' }
SAsmX86CallingConventionCDecl >> sendSelectorRegister [
	^ EAX
]

{ #category : #stack }
SAsmX86CallingConventionCDecl >> stackAlignment [
	^ 16
]

{ #category : #stack }
SAsmX86CallingConventionCDecl >> stackArgumentAlignment [
	^ 4
]

{ #category : #'register allocation' }
SAsmX86CallingConventionCDecl >> usableRegisters [
	^ {
	EAX . ECX . EDX . EBX . ESI . EDI .
	XMM0 . XMM1 . XMM2 . XMM3 . XMM4 . XMM5 . XMM6 . XMM7
	}
]
