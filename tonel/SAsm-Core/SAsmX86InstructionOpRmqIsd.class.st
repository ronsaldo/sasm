Class {
	#name : #SAsmX86InstructionOpRmqIsd,
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
SAsmX86InstructionOpRmqIsd >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterOrRegisterAddressWord
		and: [ anInstruction first size = 8
		and: [ anInstruction second isImmediateS32 ] ] ]
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpRmqIsd >> parameters: extraParameters [
	registerOpcode := extraParameters first
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpRmqIsd >> writeInstruction: instruction with: writer [
	| immediate registerAddress |
	registerAddress := instruction first.
	immediate := instruction second.
	self assert: immediate isImmediate.
	self assert: registerAddress isRegisterOrRegisterAddress.
	self assert: registerAddress size = 8.

	self write: writer rexSize: 8 rm: registerAddress reg: registerOpcode.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: registerOpcode immediate: 4.
	writer nextPutI32: immediate
	
]
