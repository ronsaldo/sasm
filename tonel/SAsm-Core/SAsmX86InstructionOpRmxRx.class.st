Class {
	#name : #SAsmX86InstructionOpRmxRx,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#instVars : [
		'mandatoryPrefix'
	],
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #accessing }
SAsmX86InstructionOpRmxRx >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction second isRegisterVector128 ]
]

{ #category : #accessing }
SAsmX86InstructionOpRmxRx >> parameters: extraParameters [
	mandatoryPrefix := #().
	extraParameters ifNotEmpty: [ 
		mandatoryPrefix := extraParameters first
	]
	
]

{ #category : #accessing }
SAsmX86InstructionOpRmxRx >> writeInstruction: instruction with: writer [
	| registerAddress register |
	registerAddress := instruction first.
	register := instruction second.

	writer nextPutAll: mandatoryPrefix.
	self write: writer rexSize: false rm: registerAddress reg: register.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: register
]
