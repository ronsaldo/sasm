Class {
	#name : #SAsmDWExpressionInstructionRegisters,
	#superclass : #SAsmDWExpressionInstruction,
	#instVars : [
		'registers'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #accessing }
SAsmDWExpressionInstructionRegisters >> registers [
	^ registers
]

{ #category : #accessing }
SAsmDWExpressionInstructionRegisters >> registers: anObject [
	registers := anObject
]

{ #category : #'as yet unclassified' }
SAsmDWExpressionInstructionRegisters >> sizeWith: writer [
	"Only supporting one register for now."
	| reg |
	registers size > 1 ifTrue: [ ^ 0 ].
	
	reg := registers first.
	reg register ifNotNil: [ 
		^ self sizeForRegister: reg register withWriter: writer
	].

	reg spillLocation ifNotNil: [
		^ self sizeForFramePointerOffset: reg spillLocation offset withWriter: writer
	].

	^ 0	
]

{ #category : #writing }
SAsmDWExpressionInstructionRegisters >> writeWith: writer to: streamBuilder [
		"Only supporting one register for now."
	| reg |
	registers size > 1 ifTrue: [ ^ self ].
	
	reg := registers first.
	reg register ifNotNil: [ 
		^ self writeRegister: reg register to: streamBuilder
	].

	reg spillLocation ifNotNil: [
		^ self writeFramePointerOffset: reg spillLocation offset to: streamBuilder
	].

	^ 0	
]
