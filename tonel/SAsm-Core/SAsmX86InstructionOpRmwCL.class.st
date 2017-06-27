Class {
	#name : #SAsmX86InstructionOpRmwCL,
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
SAsmX86InstructionOpRmwCL >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterOrRegisterAddressWord
		and: [ anInstruction second = CL ] ]
]

{ #category : #accessing }
SAsmX86InstructionOpRmwCL >> parameters: extraParameters [
	registerOpcode := extraParameters first
]

{ #category : #writing }
SAsmX86InstructionOpRmwCL >> writeInstruction: instruction with: writer [
	| registerAddress operandSize |
	registerAddress := instruction first.
	self assert: instruction second = CL.
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
	self write: writer modRM: registerAddress opcode: registerOpcode
]
