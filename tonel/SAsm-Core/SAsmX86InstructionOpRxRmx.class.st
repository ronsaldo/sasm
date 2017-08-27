Class {
	#name : #SAsmX86InstructionOpRxRmx,
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
SAsmX86InstructionOpRxRmx >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterVector128 ]
]

{ #category : #accessing }
SAsmX86InstructionOpRxRmx >> parameters: extraParameters [
	mandatoryPrefix := #().
	extraParameters ifNotEmpty: [ 
		mandatoryPrefix := extraParameters first
	]
	
]

{ #category : #accessing }
SAsmX86InstructionOpRxRmx >> writeInstruction: instruction with: writer [
	| registerAddress register |
	registerAddress := instruction second.
	register := instruction first.

	writer nextPutAll: mandatoryPrefix.
	self write: writer rexSize: 4 rm: registerAddress reg: register.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: register
]
