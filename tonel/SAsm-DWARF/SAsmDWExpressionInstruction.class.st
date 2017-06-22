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
SAsmDWExpressionInstruction >> sizeWith: writer [
	^ 1
]

{ #category : #writing }
SAsmDWExpressionInstruction >> writeWith: writer to: streamBuilder [
	streamBuilder constI8: opcode
]
