Class {
	#name : #SAsmX86InstructionOpRwRmx,
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
SAsmX86InstructionOpRwRmx >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction second isRegisterAddress or: [anInstruction second isRegisterVector128 ]]
]

{ #category : #accessing }
SAsmX86InstructionOpRwRmx >> parameters: extraParameters [
	mandatoryPrefix := #().
	extraParameters ifNotEmpty: [ 
		mandatoryPrefix := extraParameters first
	]
	
]

{ #category : #accessing }
SAsmX86InstructionOpRwRmx >> writeInstruction: instruction with: writer [
	| registerAddress register |
	registerAddress := instruction second.
	register := instruction first.

	writer nextPutAll: mandatoryPrefix.
	self write: writer rexSize: register size rm: registerAddress reg: register.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: register
]
