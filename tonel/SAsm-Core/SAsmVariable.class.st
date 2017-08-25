"
I represent a variable location in the stack.
"
Class {
	#name : #SAsmVariable,
	#superclass : #SAsmInstructionOperand,
	#instVars : [
		'index',
		'offset',
		'size',
		'alignment',
		'argument',
		'dynamicRoot',
		'virtualRegisters',
		'usedDirectly',
		'argumentPassingRegister',
		'argumentRegisterClass',
		'explicitLocalVariable'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #testing }
SAsmVariable >> actuallyUsed [
	argument ifTrue: [ ^ true ].
	virtualRegisters do: [ :vr | vr register isNil ifTrue: [ ^ true ] ].
	^ usedDirectly
]

{ #category : #initialization }
SAsmVariable >> addVirtualRegister: virtualRegister [
	virtualRegisters := virtualRegisters copyWith: virtualRegister.
]

{ #category : #accessing }
SAsmVariable >> alignment [
	^ alignment
]

{ #category : #accessing }
SAsmVariable >> alignment: anObject [
	alignment := anObject
]

{ #category : #accessing }
SAsmVariable >> argument [
	^ argument
]

{ #category : #accessing }
SAsmVariable >> argument: anObject [
	argument := anObject
]

{ #category : #accessing }
SAsmVariable >> argumentPassingRegister [
	^ argumentPassingRegister
]

{ #category : #accessing }
SAsmVariable >> argumentPassingRegister: anObject [
	argumentPassingRegister := anObject
]

{ #category : #accessing }
SAsmVariable >> argumentRegisterClass [
	^ argumentRegisterClass
]

{ #category : #accessing }
SAsmVariable >> argumentRegisterClass: anObject [
	argumentRegisterClass := anObject
]

{ #category : #accessing }
SAsmVariable >> dynamicRoot [
	^ dynamicRoot
]

{ #category : #accessing }
SAsmVariable >> dynamicRoot: anObject [
	dynamicRoot := anObject
]

{ #category : #accessing }
SAsmVariable >> explicitLocalVariable [
	^ explicitLocalVariable
]

{ #category : #accessing }
SAsmVariable >> explicitLocalVariable: anObject [
	explicitLocalVariable := anObject
]

{ #category : #accessing }
SAsmVariable >> index [
	^ index
]

{ #category : #accessing }
SAsmVariable >> index: anObject [
	index := anObject
]

{ #category : #initialization }
SAsmVariable >> initialize [
	argument := false.
	offset := 0.
	size := 0.
	index := 0.
	alignment := 1.
	dynamicRoot := false.
	usedDirectly := false.
	virtualRegisters := #().
	explicitLocalVariable := false.
]

{ #category : #testing }
SAsmVariable >> isVariable [
	^ true
]

{ #category : #testing }
SAsmVariable >> markAsSpilledExplicitly [
	usedDirectly := true
]

{ #category : #'live ranges' }
SAsmVariable >> markVirtualRegisterLiveRangePosition: liveRangePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex [
	usedDirectly := true
]

{ #category : #accessing }
SAsmVariable >> offset [
	^ offset
]

{ #category : #accessing }
SAsmVariable >> offset: anObject [
	offset := anObject
]

{ #category : #printing }
SAsmVariable >> printOn: aStream [
	aStream nextPutAll: 'local '.
	argument ifTrue: [ aStream nextPutAll: 'argument ' ].
	dynamicRoot ifTrue: [ aStream nextPutAll: 'dynroot ' ].
	aStream print: offset hex
]

{ #category : #accessing }
SAsmVariable >> size [
	^ size
]

{ #category : #accessing }
SAsmVariable >> size: anObject [
	size := anObject
]

{ #category : #accessing }
SAsmVariable >> spillClass [
	^ { size . alignment . dynamicRoot }
]

{ #category : #accessing }
SAsmVariable >> virtualRegisters [
	^ virtualRegisters
]

{ #category : #accessing }
SAsmVariable >> virtualRegisters: anObject [
	virtualRegisters := anObject
]
