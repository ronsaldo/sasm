"
I encode X86 instruction of the form:
Size Opcode + register,  immediate 16
Opcode + register,  immediate 32
Rex.W Opcode, register,  immediate 32
"
Class {
	#name : #SAsmX86InstructionOppRwIw,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #writing }
SAsmX86InstructionOppRwIw >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterWord
		and: [ anInstruction second isImmediate
		and: [anInstruction second isImmediate32 ] ] ]
]

{ #category : #writing }
SAsmX86InstructionOppRwIw >> writeInstruction: instruction with: writer [
	| register value operandSize |
	register := instruction first.
	value := instruction second.
	self assert: register isRegister.
	operandSize := register size.
	operandSize = 2 ifTrue: [
		self write: writer sizeOverrideIf: writer isShortMode not.
		self write: writer rexRM: register.
		self write: writer opcodePlusRegister: register.
		^ writer nextPutI16: value
	].
	operandSize = 4 ifTrue: [
		self write: writer sizeOverrideIf: writer isShortMode.
		self write: writer rexRM: register.
		self write: writer opcodePlusRegister: register.
		^ writer nextPutI32: value
	].
	operandSize = 8 ifTrue: [
		self write: writer rexSize: operandSize rm: register.
		self write: writer opcodePlusRegister: register.
		^ writer nextPutI32: value
	].
	self invalidInstruction
	
]
