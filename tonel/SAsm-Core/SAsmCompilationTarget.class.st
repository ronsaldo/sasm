Class {
	#name : #SAsmCompilationTarget,
	#superclass : #Object,
	#instVars : [
		'operatingSystemName',
		'objectModel',
		'executable'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #'as yet unclassified' }
SAsmCompilationTarget >> cFunctionPrefix [
	^ ''
]

{ #category : #'as yet unclassified' }
SAsmCompilationTarget >> cVariablePrefix [
	^ ''
]

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

{ #category : #'as yet unclassified' }
SAsmCompilationTarget >> emitNopOfSize: paddingSize with: writer [
	self subclassResponsibility
]

{ #category : #accessing }
SAsmCompilationTarget >> executable [
	^ executable
]

{ #category : #accessing }
SAsmCompilationTarget >> executable: anObject [
	executable := anObject
]

{ #category : #'operating systems' }
SAsmCompilationTarget >> freebsd [
	self operatingSystemName: #freebsd
]

{ #category : #accessing }
SAsmCompilationTarget >> functionEntryPointAlignment [
	^ 16
]

{ #category : #accessing }
SAsmCompilationTarget >> functionExitPointAlignment [
	^ 16
]

{ #category : #testing }
SAsmCompilationTarget >> hasPositionIndependentCode [
	^ false
]

{ #category : #initialization }
SAsmCompilationTarget >> initialize [
	super initialize.
	executable := false.
	Smalltalk os isUnix ifTrue: [ 
		self flag: 'Support other unixes'.
		operatingSystemName := #linux
	].
	Smalltalk os isMacOSX ifTrue: [ 
		operatingSystemName := #osx
	].
	(Smalltalk os isWin32 or: [Smalltalk os isWin64]) ifTrue: [ 
		operatingSystemName := #win32
	].

]

{ #category : #testing }
SAsmCompilationTarget >> isBigEndian [
	^ self isLittleEndian not
]

{ #category : #testing }
SAsmCompilationTarget >> isLittleEndian [
	^ true
]

{ #category : #testing }
SAsmCompilationTarget >> isOSX [
	^ operatingSystemName = #osx
]

{ #category : #testing }
SAsmCompilationTarget >> isWindows [
	^ operatingSystemName = #windows
]

{ #category : #'operating systems' }
SAsmCompilationTarget >> linux [
	self operatingSystemName: #linux
]

{ #category : #'calling conventions' }
SAsmCompilationTarget >> nakedCallingConvention [
	^ self callingConventionNamed: #naked
]

{ #category : #testing }
SAsmCompilationTarget >> needsSlotForGOTPointer [
	^ false
]

{ #category : #accessing }
SAsmCompilationTarget >> objectModel [
	^ objectModel
]

{ #category : #accessing }
SAsmCompilationTarget >> objectModel: anObject [
	objectModel := anObject
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

{ #category : #accessing }
SAsmCompilationTarget >> usesMachO64 [
	self subclassResponsibility
]

{ #category : #'operating systems' }
SAsmCompilationTarget >> win32 [
	self operatingSystemName: #win32
]

{ #category : #'object files' }
SAsmCompilationTarget >> writeObject: binaryObject toFileNamed: fileName [
	self isWin32 ifTrue: [ ^ binaryObject writeCoffToFileNamed: fileName ].
	self isOSX ifTrue: [ ^ binaryObject writeMachOToFileNamed: fileName ].
	^ binaryObject writeElfToFileNamed: fileName
]
