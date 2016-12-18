Class {
	#name : #SAsmX86InstructionOpRmwIw,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#instVars : [
		'registerOpcode'
	],
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionOpRmwIw >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterOrRegisterAddressWord
		and: [ anInstruction second isImmediate32 ] ]
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpRmwIw >> parameters: extraParameters [
	registerOpcode := extraParameters first
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpRmwIw >> writeInstruction: instruction with: writer [
	| immediate registerAddress operandSize |
	registerAddress := instruction first.
	immediate := instruction second.
	self assert: immediate isImmediate.
	self assert: registerAddress isRegisterOrRegisterAddress.
	operandSize := registerAddress size.
	self assert: operandSize > 1.
	operandSize = 2 ifTrue: [
		self write: writer sizeOverrideIf: writer isShortMode not.
	].
	operandSize = 4 ifTrue: [
		self write: writer sizeOverrideIf: writer isShortMode.
	].
	self write: writer rexSize: operandSize rm: registerAddress reg: registerOpcode.
	writer nextPutAll: opcode.
	operandSize = 2 ifTrue: [ 
		self write: writer modRM: registerAddress reg: registerOpcode immediate: 2.
		writer nextPutI16: immediate
	] ifFalse: [
		self write: writer modRM: registerAddress reg: registerOpcode immediate: 4.
		writer nextPutI32: immediate
	]
	
]
