Class {
	#name : #SAsmConstantPointer,
	#superclass : #SAsmInstructionOperand,
	#instVars : [
		'address',
		'size',
		'alignment',
		'floatingPoint'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #accessing }
SAsmConstantPointer >> address [
	^ address
]

{ #category : #accessing }
SAsmConstantPointer >> address: anObject [
	address := anObject
]

{ #category : #accessing }
SAsmConstantPointer >> alignment [
	^ alignment
]

{ #category : #accessing }
SAsmConstantPointer >> alignment: anObject [
	alignment := anObject
]

{ #category : #converting }
SAsmConstantPointer >> asX86PointerOfSize: pointerSize withBuilder: streamBuilder [
	^ SAsmX86RegisterAddress new size: pointerSize; displacement: (address copyWithStreamBuilder: streamBuilder)
]

{ #category : #converting }
SAsmConstantPointer >> asX86PointerWithBuilder: streamBuilder [
	^ SAsmX86RegisterAddress new size: size; displacement: (address copyWithStreamBuilder: streamBuilder)
]

{ #category : #copying }
SAsmConstantPointer >> copyWithStreamBuilder: streamBuilder [
	self error: 'Cannot copy a constant pointer directly.'
]

{ #category : #accessing }
SAsmConstantPointer >> floatingPoint [
	^ floatingPoint
]

{ #category : #accessing }
SAsmConstantPointer >> floatingPoint: anObject [
	floatingPoint := anObject
]

{ #category : #initialization }
SAsmConstantPointer >> initialize [
	super initialize.
	floatingPoint := false.
]

{ #category : #testing }
SAsmConstantPointer >> isConstantPointer [
	^ true
]

{ #category : #testing }
SAsmConstantPointer >> isDoubleFloatOperand [
	^ floatingPoint and: [ size = 8 ]
]

{ #category : #testing }
SAsmConstantPointer >> isFloatOperand [
	^ floatingPoint and: [ size = 4 ]
]

{ #category : #testing }
SAsmConstantPointer >> isFloatingPointConstantPointer [
	^ floatingPoint
]

{ #category : #testing }
SAsmConstantPointer >> isFloatingPointOperand [
	^ floatingPoint
]

{ #category : #accessing }
SAsmConstantPointer >> size [
	^ size
]

{ #category : #accessing }
SAsmConstantPointer >> size: anObject [
	size := anObject
]
