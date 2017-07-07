Class {
	#name : #SAsmX86InstructionOpM64fp,
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
SAsmX86InstructionOpM64fp >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 1
		and: [ anInstruction first isRegisterAddress64  ]
]

{ #category : #accessing }
SAsmX86InstructionOpM64fp >> parameters: extraParameters [
	registerOpcode := extraParameters first
]

{ #category : #writing }
SAsmX86InstructionOpM64fp >> writeInstruction: instruction with: writer [
	| registerAddress |
	registerAddress := instruction first.
	self assert: registerAddress isRegisterAddress64.
	
	self write: writer rexSize: 1 rm: registerAddress reg: registerOpcode.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress opcode: registerOpcode.

	
]
