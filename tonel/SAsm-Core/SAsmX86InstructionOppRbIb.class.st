"
I encode X86 instruction of the form:
Opcode + register,  immediate 8
"
Class {
	#name : #SAsmX86InstructionOppRbIb,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #writing }
SAsmX86InstructionOppRbIb >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterI8
		and: [ anInstruction second isImmediate ] ]
]

{ #category : #writing }
SAsmX86InstructionOppRbIb >> writeInstruction: instruction with: writer [
	| register value |
	register := instruction first.
	value := instruction second.
	self assert: register isRegisterI8.
	self assert: register size = 1.
	self write: writer opcodePlusRegister: register.
	^ writer nextPutI8: value
]
