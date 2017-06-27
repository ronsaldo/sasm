Class {
	#name : #'SAsmX86InstructionOpRmbI_1',
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
SAsmX86InstructionOpRmbI_1 >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterOrRegisterAddressI8 
		and: [ anInstruction second isImmediate8 and: [anInstruction second value = 1 ] ] ]
]

{ #category : #accessing }
SAsmX86InstructionOpRmbI_1 >> parameters: extraParameters [
	registerOpcode := extraParameters first
]

{ #category : #writing }
SAsmX86InstructionOpRmbI_1 >> writeInstruction: instruction with: writer [
	| immediate registerAddress operandSize |
	registerAddress := instruction first.
	immediate := instruction second.
	self assert: immediate isImmediate.
	self assert: registerAddress isRegisterOrRegisterAddress.
	operandSize := registerAddress size.
	self assert: operandSize = 1.
	
	self write: writer rexSize: operandSize rm: registerAddress reg: registerOpcode.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: registerOpcode
]
