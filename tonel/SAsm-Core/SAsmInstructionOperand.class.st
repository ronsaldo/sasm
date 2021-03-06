Class {
	#name : #SAsmInstructionOperand,
	#superclass : #SAsmObject,
	#category : #'SAsm-Core-Generic'
}

{ #category : #converting }
SAsmInstructionOperand >> asSAsmInstructionOperand [
	^ self
]

{ #category : #'as yet unclassified' }
SAsmInstructionOperand >> copyWithStreamBuilder: streamBuilder [
	^ self copy
]

{ #category : #testing }
SAsmInstructionOperand >> hasFixedSize [
	^ true
]

{ #category : #testing }
SAsmInstructionOperand >> isConstantPointer [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isDoubleFloatOperand [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isDoubleFloatRegister [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isFloatOperand [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isFloatRegister [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isFloatingPointConstantPointer [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isFloatingPointOperand [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isFloatingPointRegister [
	^ self isFloatRegister or: [ self isDoubleFloatRegister ]
]

{ #category : #testing }
SAsmInstructionOperand >> isImmediate [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isImmediate32 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isImmediateConstant [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isImmediateS16 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isImmediateS32 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isImmediateS64 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isImmediateS8 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isImmediateSymbolWithAddend [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isImmediateU16 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isImmediateU32 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isImmediateU64 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isImmediateU8 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isInstructionOperand [
	^ true
]

{ #category : #testing }
SAsmInstructionOperand >> isIntegerRegister [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegister [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterAddress [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterAddress32 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterAddress64 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterAddress80 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterI16 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterI32 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterI64 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterI8 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterOrRegisterAddress [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterOrRegisterAddressI8 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterOrRegisterAddressVector128 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterOrRegisterAddressVector256 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterOrRegisterAddressWord [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterVector128 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterVector256 [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isRegisterWord [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isSymbol [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isVariable [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isVectorRegister [
	^ false
]

{ #category : #testing }
SAsmInstructionOperand >> isVirtualRegister [
	^ false
]

{ #category : #'live ranges' }
SAsmInstructionOperand >> markVirtualRegisterLiveRangePosition: liveRangePosition [
	self markVirtualRegisterLiveRangePosition: liveRangePosition blockIndex: -1 predecessorBlockIndex: -1
]

{ #category : #'live ranges' }
SAsmInstructionOperand >> markVirtualRegisterLiveRangePosition: liveRangePosition blockIndex: blockIndex predecessorBlockIndex: predecessorBlockIndex [
]
