Class {
	#name : #SAsmCompilationTarget,
	#superclass : #Object,
	#category : #'SAsm-Core-Generic'
}

{ #category : #'calling conventions' }
SAsmCompilationTarget >> callingConventionNamed: aCallingConventionName [
	self subclassResponsibility
]

{ #category : #'calling conventions' }
SAsmCompilationTarget >> cdeclCallingConvention [
	^ self callingConventionNamed: #cdecl
]

{ #category : #'calling conventions' }
SAsmCompilationTarget >> defaultCallingConvention [
	^ self cdeclCallingConvention
]

{ #category : #'calling conventions' }
SAsmCompilationTarget >> nakedCallingConvention [
	^ self callingConventionNamed: #naked
]

{ #category : #'calling conventions' }
SAsmCompilationTarget >> smalltalkCallingConvention [
	^ self callingConventionNamed: #smalltalk
]

{ #category : #'calling conventions' }
SAsmCompilationTarget >> stdcallCallingConvention [
	^ self callingConventionNamed: #stdcall
]

{ #category : #accessing }
SAsmCompilationTarget >> usesElf64 [
	self subclassResponsibility
]
