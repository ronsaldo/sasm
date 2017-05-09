Class {
	#name : #SAsmX86InstructionOpRwRmwI8,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionOpRwRmwI8 >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 3
		and: [ anInstruction first isRegisterWord
		and: [ anInstruction second isRegisterOrRegisterAddress
		and: [ anInstruction third isImmediateS8 ] ] ]
]

{ #category : #writing }
SAsmX86InstructionOpRwRmwI8 >> writeInstruction: instruction with: writer [
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
	self write: writer modRM: registerAddress reg: register valueLow immediate: 1.
	writer nextPutI8: immediate
]
