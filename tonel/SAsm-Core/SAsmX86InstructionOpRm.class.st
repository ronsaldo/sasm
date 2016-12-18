Class {
	#name : #SAsmX86InstructionOpRm,
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
SAsmX86InstructionOpRm >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 1
		and: [ anInstruction first isRegisterOrRegisterAddressWord ]
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpRm >> parameters: extraParameters [
	registerOpcode := extraParameters first
]

{ #category : #testing }
SAsmX86InstructionOpRm >> writeInstruction: instruction with: writer [
	| registerAddress |
	registerAddress := instruction first.
	self assert: registerAddress isRegisterOrRegisterAddress.
	
	self write: writer rexSize: 1 rm: registerAddress reg: registerOpcode.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: registerOpcode immediate: 1.

	
]
