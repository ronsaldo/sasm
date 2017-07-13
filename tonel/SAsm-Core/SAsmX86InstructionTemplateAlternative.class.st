Class {
	#name : #SAsmX86InstructionTemplateAlternative,
	#superclass : #SAsmObject,
	#instVars : [
		'opcode'
	],
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86InstructionTemplateAlternative >> canWriteInstruction: anInstruction [
	^ self subclassResponsibility
]

{ #category : #accessing }
SAsmX86InstructionTemplateAlternative >> maxSize [
	^ 16
]

{ #category : #accessing }
SAsmX86InstructionTemplateAlternative >> opcode [
	^ opcode
]

{ #category : #accessing }
SAsmX86InstructionTemplateAlternative >> opcode: anObject [
	opcode := anObject
]

{ #category : #accessing }
SAsmX86InstructionTemplateAlternative >> parameters: extraParameters [
]

{ #category : #writing }
SAsmX86InstructionTemplateAlternative >> write: writer modRM: registerOrAddress opcode: extraOpcode [
	registerOrAddress encodeModRMWithOpcode: extraOpcode immediate: 0 longMode: writer isLongMode into: writer
]

{ #category : #writing }
SAsmX86InstructionTemplateAlternative >> write: writer modRM: registerOrAddress opcode: extraOpcode immediate: immediateSize [
	registerOrAddress encodeModRMWithOpcode: extraOpcode immediate: immediateSize longMode: writer isLongMode into: writer
]

{ #category : #writing }
SAsmX86InstructionTemplateAlternative >> write: writer modRM: registerOrAddress reg: reg [
	registerOrAddress encodeModRMWithOpcode: reg valueLow immediate: 0 longMode: writer isLongMode into: writer
]

{ #category : #writing }
SAsmX86InstructionTemplateAlternative >> write: writer modRM: registerOrAddress reg: reg immediate: immediateSize [
	registerOrAddress encodeModRMWithOpcode: reg immediate: 0 longMode: writer isLongMode into: writer
]

{ #category : #writing }
SAsmX86InstructionTemplateAlternative >> write: writer opcodePlusRegister: register [
	writer nextPut: opcode first + register valueLow
	
]

{ #category : #writing }
SAsmX86InstructionTemplateAlternative >> write: writer rexRM: rm [
	| bbit xbit lowBits |
	rm isRegister ifTrue: [ 
		bbit := rm isHighRegister asBit.
		xbit := 0.
	] ifFalse: [ 
		bbit := (rm base isNotNil and: [ rm base isHighRegister ]) asBit.
		xbit := (rm index isNotNil and: [ rm index isHighRegister ]) asBit.
	].
	lowBits := (xbit << 1) | (bbit).
	
	lowBits ~= 0 ifTrue: [ 
		self assert: writer isLongMode.
		writer nextPutC8: 16r40 | lowBits
	]
]

{ #category : #writing }
SAsmX86InstructionTemplateAlternative >> write: writer rexRM: rm reg: reg [
	self write: writer rexSize: 1 rm: rm reg: reg
]

{ #category : #writing }
SAsmX86InstructionTemplateAlternative >> write: writer rexReg: reg [
	reg isHighRegister ifTrue: [ 
		self assert: writer isLongMode.
		writer nextPutC8: 16r44
	]
]

{ #category : #writing }
SAsmX86InstructionTemplateAlternative >> write: writer rexSize: size [
	self write: writer rexSize: size rm: RAX reg: RAX
]

{ #category : #writing }
SAsmX86InstructionTemplateAlternative >> write: writer rexSize: size rm: register [
	self write: writer rexSize: size rm: register reg: EAX
]

{ #category : #writing }
SAsmX86InstructionTemplateAlternative >> write: writer rexSize: size rm: first reg: second [
	| wbit rbit xbit bbit lowBits |
	wbit := (size = 8) asBit.
	rbit := 0.
	xbit := 0.
	bbit := 0.
	first isRegisterOrRegisterAddress  ifTrue: [ 
		first isRegister ifTrue: [
			bbit := first isHighRegister asBit
		] ifFalse: [
			bbit := (first base isNotNil and: [ first base isHighRegister ]) asBit.
			xbit := (first index isNotNil and: [ first index isHighRegister ]) asBit.
		]
	].

	(second isInteger not and: [ second isRegister ]) ifTrue: [
		rbit := second isHighRegister asBit.
	].

	lowBits := (wbit << 3) | (rbit << 2) | (xbit << 1) | (bbit).
	lowBits ~= 0 ifTrue: [ 
		self assert: writer isLongMode.
		writer nextPutC8: 16r40 | lowBits
	]
]

{ #category : #writing }
SAsmX86InstructionTemplateAlternative >> write: writer sizeOverrideIf: aBoolean [
	aBoolean ifTrue: [
		writer nextPut: 16r66
	]
]

{ #category : #writing }
SAsmX86InstructionTemplateAlternative >> writeInstruction: instruction with: writer [
	self subclassResponsibility
]
