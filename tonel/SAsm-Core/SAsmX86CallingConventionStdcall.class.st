Class {
	#name : #SAsmX86CallingConventionStdcall,
	#superclass : #SAsmX86CallingConventionCDecl,
	#category : #'SAsm-Core-X86'
}

{ #category : #stack }
SAsmX86CallingConventionStdcall >> isStackCleanedByCaller [
	^ false
]
