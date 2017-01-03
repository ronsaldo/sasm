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
		'virtualRegisters'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #testing }
SAsmVariable >> actuallyUsed [
	argument ifTrue: [ ^ true ].
	virtualRegisters do: [ :vr | vr register isNil ifTrue: [ ^ true ] ].
	^ false
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
SAsmVariable >> dynamicRoot [
	^ dynamicRoot
]

{ #category : #accessing }
SAsmVariable >> dynamicRoot: anObject [
	dynamicRoot := anObject
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
	virtualRegisters := #().
]

{ #category : #testing }
SAsmVariable >> isVariable [
	^ true
]

{ #category : #accessing }
SAsmVariable >> offset [
	^ offset
]

{ #category : #accessing }
SAsmVariable >> offset: anObject [
	offset := anObject
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