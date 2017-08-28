Class {
	#name : #SAsmX86InstructionOpRxRmxI8,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#instVars : [
		'mandatoryPrefix'
	],
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionOpRxRmxI8 >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 3
		and: [ anInstruction first isRegisterVector128
		and: [ anInstruction second isRegisterOrRegisterAddressVector128
		and: [ anInstruction third isImmediateU8 ] ] ]
]

{ #category : #testing }
SAsmX86InstructionOpRxRmxI8 >> parameters: extraParameters [
	mandatoryPrefix := #().
	extraParameters ifNotEmpty: [ 
		mandatoryPrefix := extraParameters first
	]
	
]

{ #category : #testing }
SAsmX86InstructionOpRxRmxI8 >> writeInstruction: instruction with: writer [
	| registerAddress register |
	registerAddress := instruction second.
	register := instruction first.

	writer nextPutAll: mandatoryPrefix.
	self write: writer rexSize: 4 rm: registerAddress reg: register.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: register valueLow immediate: 1.
	writer nextPutI8: instruction third.
]
