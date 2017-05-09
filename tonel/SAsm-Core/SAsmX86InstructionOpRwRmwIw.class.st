Class {
	#name : #SAsmX86InstructionOpRwRmwIw,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionOpRwRmwIw >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 3
		and: [ anInstruction first isRegisterWord
		and: [ anInstruction second isRegisterOrRegisterAddress
		and: [ anInstruction third isImmediate32 ] ] ]
]

{ #category : #writing }
SAsmX86InstructionOpRwRmwIw >> writeInstruction: instruction with: writer [
	| register registerAddress operandSize immediate |
	register := instruction first.
	registerAddress := instruction second.
	immediate := instruction third.
	self assert: register isRegister.
	self assert: registerAddress isRegisterOrRegisterAddress.
	self assert: immediate isImmediate.
	operandSize := register size.
	self assert: operandSize > 1.
	operandSize = 2 ifTrue: [
		self write: writer sizeOverrideIf: writer isShortMode not.
	].
	operandSize = 4 ifTrue: [
		self write: writer sizeOverrideIf: writer isShortMode.
	].
	self write: writer rexSize: operandSize rm: registerAddress reg: register.
	writer nextPutAll: opcode.
	operandSize = 2 ifTrue: [ 
		self write: writer modRM: registerAddress reg: register valueLow immediate: 2.
		writer nextPutI16: immediate
	] ifFalse: [
		self write: writer modRM: registerAddress reg: register valueLow immediate: 4.
		writer nextPutI32: immediate
	]
]
