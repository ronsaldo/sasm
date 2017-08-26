Class {
	#name : #SAsmConstantPointer,
	#superclass : #SAsmInstructionOperand,
	#instVars : [
		'address',
		'size'
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

{ #category : #testing }
SAsmConstantPointer >> isConstantPointer [
	^ true
]

{ #category : #accessing }
SAsmConstantPointer >> size [
	^ size
]

{ #category : #accessing }
SAsmConstantPointer >> size: anObject [
	size := anObject
]
