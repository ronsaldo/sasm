Class {
	#name : #SAsmX86InstructionOpRxRmw,
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
SAsmX86InstructionOpRxRmw >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2 and:
	[ anInstruction first isRegisterVector128 and:
	[ anInstruction second isRegisterOrRegisterAddress ]]
]

{ #category : #accessing }
SAsmX86InstructionOpRxRmw >> parameters: extraParameters [
	mandatoryPrefix := #().
	extraParameters ifNotEmpty: [ 
		mandatoryPrefix := extraParameters first
	]
	
]

{ #category : #writing }
SAsmX86InstructionOpRxRmw >> writeInstruction: instruction with: writer [
	| registerAddress register operandSize |
	registerAddress := instruction second.
	register := instruction first.
	operandSize := registerAddress size.
	
	writer nextPutAll: mandatoryPrefix.
	self write: writer rexSize: operandSize rm: registerAddress reg: register.
	writer nextPutAll: opcode.
	self write: writer modRM: registerAddress reg: register
]
