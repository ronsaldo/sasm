Class {
	#name : #SAsmCallingConvention,
	#superclass : #SAsmObject,
	#category : #'SAsm-Core-Generic'
}

{ #category : #'register allocation' }
SAsmCallingConvention >> allocatableRegisters [
	^ self usableRegisters copyWithoutAll: self scratchRegisters
]

{ #category : #'register ownership' }
SAsmCallingConvention >> calledRegisters [
	^ self usableRegisters
]

{ #category : #'register ownership' }
SAsmCallingConvention >> callerRegisters [
	^ #()
]

{ #category : #stack }
SAsmCallingConvention >> canBeFrameLess [
	^ false
]

{ #category : #'parameter passing' }
SAsmCallingConvention >> floatArgumentRegisters [
	^ #()
]

{ #category : #'parameter passing' }
SAsmCallingConvention >> gotRegister [
	^ nil
]

{ #category : #stack }
SAsmCallingConvention >> hasContextMetadata [
	^ false
]

{ #category : #stack }
SAsmCallingConvention >> hasSegmentedStack [
	^ false
]

{ #category : #'parameter passing' }
SAsmCallingConvention >> integerArgumentRegisters [
	^ #()
]

{ #category : #testing }
SAsmCallingConvention >> isNaked [
	^ false
]

{ #category : #stack }
SAsmCallingConvention >> isStackCleanedByCaller [
	^ true
]

{ #category : #'return value passing' }
SAsmCallingConvention >> resultFloatRegister [
	^ nil
]

{ #category : #'return value passing' }
SAsmCallingConvention >> resultInt2Register [
	^ nil
]

{ #category : #'return value passing' }
SAsmCallingConvention >> resultIntRegister [
	^ nil
]

{ #category : #'register allocation' }
SAsmCallingConvention >> scratchRegisters [
	^ #()
]

{ #category : #'message passing' }
SAsmCallingConvention >> sendDescriptionRegister [
	self subclassResponsibility
]

{ #category : #'message passing' }
SAsmCallingConvention >> sendLookupBehindRegister [
	self subclassResponsibility
]

{ #category : #'message passing' }
SAsmCallingConvention >> sendSelectorRegister [
	self subclassResponsibility
]

{ #category : #stack }
SAsmCallingConvention >> stackAlignment [
	self subclassResponsibility
]

{ #category : #stack }
SAsmCallingConvention >> stackArgumentAlignment [
	self subclassResponsibility
]

{ #category : #'register allocation' }
SAsmCallingConvention >> usableRegisters [
	^ #()
]
