Class {
	#name : #SAsmX86CallingConventionNaked,
	#superclass : #SAsmX86CallingConvention,
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86CallingConventionNaked >> isNaked [
	^ true
]

{ #category : #accessing }
SAsmX86CallingConventionNaked >> name [
	^ #naked
]

{ #category : #accessing }
SAsmX86CallingConventionNaked >> stackAlignment [
	^ 1
]
