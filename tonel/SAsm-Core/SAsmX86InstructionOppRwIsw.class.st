"
I encode X86 instruction of the form:
Size Opcode + register,  immediate 16
Opcode + register,  immediate 32
Rex.W Opcode, register,  signed immediate 32
"
Class {
	#name : #SAsmX86InstructionOppRwIsw,
	#superclass : #SAsmX86InstructionOppRwIw,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86InstructionOppRwIsw >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterWord
		and: [ anInstruction second isImmediate
		and: [ [anInstruction first isRegisterI64 not] or: [anInstruction second isImmediateS32] ] ] ]
]
