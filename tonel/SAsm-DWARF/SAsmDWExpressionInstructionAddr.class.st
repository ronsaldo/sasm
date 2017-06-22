Class {
	#name : #SAsmDWExpressionInstructionAddr,
	#superclass : #SAsmDWExpressionInstruction,
	#instVars : [
		'value'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #initialization }
SAsmDWExpressionInstructionAddr >> initialize [
	super initialize.
	opcode := DW_OP_addr.
]

{ #category : #'as yet unclassified' }
SAsmDWExpressionInstructionAddr >> sizeWith: writer [
	^ (super sizeWith: writer) + writer pointerSize
]

{ #category : #accessing }
SAsmDWExpressionInstructionAddr >> value [
	^ value
]

{ #category : #accessing }
SAsmDWExpressionInstructionAddr >> value: anObject [
	value := anObject asSAsmInstructionOperand
]

{ #category : #writing }
SAsmDWExpressionInstructionAddr >> writeWith: writer to: streamBuilder [
	super writeWith: writer to: streamBuilder.
	streamBuilder const: (value copyWithStreamBuilder: streamBuilder) size: writer pointerSize
]
