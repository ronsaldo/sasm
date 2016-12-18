Class {
	#name : #SAsmX86InstructionOpRmbIb,
	#superclass : #SAsmX86InstructionTemplateAlternative,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmX86InstructionOpRmbIb >> canWriteInstruction: anInstruction [
	^ anInstruction argumentCount = 2
		and: [ anInstruction first isRegisterOrRegisterAddressI8
		and: [ anInstruction second isImmediate ] ]
]
