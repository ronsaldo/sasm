Class {
	#name : #SAsmDWExpressionInstruction,
	#superclass : #SAsmDWObject,
	#instVars : [
		'opcode'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #accessing }
SAsmDWExpressionInstruction >> opcode [
	^ opcode
]

{ #category : #accessing }
SAsmDWExpressionInstruction >> opcode: anObject [
	opcode := anObject
]

{ #category : #'as yet unclassified' }
SAsmDWExpressionInstruction >> sizeForFramePointerOffset: offset withWriter: writer [
	^ (self sizeForRegister: writer streamBuilder target framePointerRegister withWriter: writer) + (writer streamBuilder sleb128Size: offset)
]

{ #category : #'as yet unclassified' }
SAsmDWExpressionInstruction >> sizeForRegister: register withWriter: writer [
	| mappedRegister |
	mappedRegister := writer streamBuilder target mapRegisterToDwarf: register.
	^ mappedRegister > 31 ifTrue: [ 1 + (writer streamBuilder uleb128Size: mappedRegister) ] ifFalse: [ 1 ]
]

{ #category : #'as yet unclassified' }
SAsmDWExpressionInstruction >> sizeWith: writer [
	^ 1
]

{ #category : #writing }
SAsmDWExpressionInstruction >> writeFramePointerOffset: offset to: streamBuilder [
	| mappedRegister |
	mappedRegister := streamBuilder target mapRegisterToDwarf: streamBuilder target framePointerRegister.
	mappedRegister > 31 ifTrue: [
		streamBuilder constI8: DW_OP_bregx;
			uleb128: mappedRegister
	] ifFalse: [
		streamBuilder constI8: DW_OP_breg0 value + mappedRegister
	].
	streamBuilder sleb128: offset

]

{ #category : #writing }
SAsmDWExpressionInstruction >> writeRegister: register to: streamBuilder [
	| mappedRegister |
	mappedRegister := streamBuilder target mapRegisterToDwarf: register.
	mappedRegister > 31 ifTrue: [
		streamBuilder constI8: DW_OP_regx;
			uleb128: mappedRegister
	] ifFalse: [
		streamBuilder constI8: DW_OP_reg0 value + mappedRegister
	]

]

{ #category : #writing }
SAsmDWExpressionInstruction >> writeWith: writer to: streamBuilder [
	streamBuilder constI8: opcode
]
