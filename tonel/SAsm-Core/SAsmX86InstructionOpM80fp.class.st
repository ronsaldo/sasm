Class {
	#name : #SAsmX86InstructionOpM80fp,
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
SAsmX86InstructionOpM80fp >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 1
		and: [ anInstruction first isRegisterAddress80  ]
]

{ #category : #accessing }
SAsmX86InstructionOpM80fp >> parameters: extraParameters [
	registerOpcode := extraParameters first
]

{ #category : #writing }
SAsmX86InstructionOpM80fp >> writeInstruction: instruction with: writer [
	| registerAddress |
	registerAddress := instruction first.
	self assert: registerAddress isRegisterAddress80.
	
	self write: writer rexSize: 1 rm: registerAddress reg: registerOpcode.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress opcode: registerOpcode.

	
]
