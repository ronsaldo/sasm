Class {
	#name : #SAsmCompilationTarget,
	#superclass : #Object,
	#instVars : [
		'operatingSystemName'
	],
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

{ #category : #'as yet unclassified' }
SAsmCompilationTarget >> csymbolPrefix [
	^ ''
]

{ #category : #'calling conventions' }
SAsmCompilationTarget >> defaultCallingConvention [
	^ self cdeclCallingConvention
]

{ #category : #'as yet unclassified' }
SAsmCompilationTarget >> emitNopOfSize: paddingSize with: writer [
	self subclassResponsibility
]

{ #category : #'operating systems' }
SAsmCompilationTarget >> freebsd [
	self operatingSystemName: #freebsd
]

{ #category : #accessing }
SAsmCompilationTarget >> functionEntryPointAlignment [
	^ 16
]

{ #category : #testing }
SAsmCompilationTarget >> hasPositionIndependentCode [
	^ false
]

{ #category : #initialization }
SAsmCompilationTarget >> initialize [
	super initialize.
	operatingSystemName := #linux
]

{ #category : #testing }
SAsmCompilationTarget >> isBigEndian [
	^ self isLittleEndian not
]

{ #category : #testing }
SAsmCompilationTarget >> isLittleEndian [
	^ true
]

{ #category : #'operating systems' }
SAsmCompilationTarget >> linux [
	self operatingSystemName: #linux
]

{ #category : #'calling conventions' }
SAsmCompilationTarget >> nakedCallingConvention [
	^ self callingConventionNamed: #naked
]

{ #category : #accessing }
SAsmCompilationTarget >> operatingSystemName [
	^ operatingSystemName
]

{ #category : #accessing }
SAsmCompilationTarget >> operatingSystemName: anObject [
	operatingSystemName := anObject
]

{ #category : #'operating systems' }
SAsmCompilationTarget >> osx [
	self operatingSystemName: #osx
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

{ #category : #'operating systems' }
SAsmCompilationTarget >> win32 [
	self operatingSystemName: #win32
]
