Class {
	#name : #SAsmX86InstructionOpAXIw,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpAXIw >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegister
		and: [ anInstruction first value = 0
		and: [ anInstruction second isImmediate32 ] ] ]
]

{ #category : #writing }
SAsmX86InstructionOpAXIw >> writeInstruction: instruction with: writer [
	self write: writer rexSize: instruction first size.
	writer nextPutAll: opcode.
	writer isShortMode ifTrue: [ 
		writer nextPutI16: instruction second first
	] ifFalse: [
		writer nextPutI32: instruction arguments second
	]
]
