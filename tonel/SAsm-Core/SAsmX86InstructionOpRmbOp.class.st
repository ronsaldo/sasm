Class {
	#name : #SAsmX86InstructionOpRmbOp,
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
SAsmX86InstructionOpRmbOp >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 1
		and: [ anInstruction first isRegisterOrRegisterAddressI8]
]

{ #category : #testing }
SAsmX86InstructionOpRmbOp >> parameters: extraParameters [
	registerOpcode := extraParameters first
]

{ #category : #testing }
SAsmX86InstructionOpRmbOp >> writeInstruction: instruction with: writer [
	| registerOrAddress |
	registerOrAddress := instruction first.
	self assert: registerOrAddress isRegisterOrRegisterAddressI8.
	self assert: registerOrAddress size = 1.
	self write: writer rexSize: 1 rm: registerOrAddress reg: 0.
	writer nextPut: opcode.
	self write: writer modRM: registerOrAddress opcode: registerOpcode
]
