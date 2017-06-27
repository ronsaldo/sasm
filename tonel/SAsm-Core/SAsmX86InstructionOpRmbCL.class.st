Class {
	#name : #SAsmX86InstructionOpRmbCL,
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
SAsmX86InstructionOpRmbCL >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterOrRegisterAddressI8 
		and: [ anInstruction second = CL ] ]
]

{ #category : #accessing }
SAsmX86InstructionOpRmbCL >> parameters: extraParameters [
	registerOpcode := extraParameters first
]

{ #category : #writing }
SAsmX86InstructionOpRmbCL >> writeInstruction: instruction with: writer [
	| registerAddress operandSize |
	registerAddress := instruction first.
	self assert: instruction second = CL.
	self assert: registerAddress isRegisterOrRegisterAddress.
	operandSize := registerAddress size.
	self assert: operandSize = 1.
	
	self write: writer rexSize: operandSize rm: registerAddress reg: registerOpcode.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: registerOpcode
]
