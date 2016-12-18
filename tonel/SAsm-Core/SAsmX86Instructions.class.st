Class {
	#name : #SAsmX86Instructions,
	#superclass : #SharedPool,
	#classVars : [
		'MOV',
		'POP',
		'PUSH',
		'RET'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'class initialization' }
SAsmX86Instructions class >> initialize [
	super initialize.
	
	self initializeInstructions.
]

{ #category : #parsing }
SAsmX86Instructions class >> initializeInstructions [
	self parseInstructionTable: #(
		(MOV
			(OppRbIb 16rB0)
			(OppRwIww 16rB8)
			(OpRmbIb 16rC6)
			(OpRmwIw 16rC7)
			
			(OpRmbRb 16r88)
			(OpRmwRw 16r89)
			(OpRbRmb 16r8A)
			(OpRwRmw 16r8B)
		)
		
		(POP
			(OppR 16r58)
			(OpRm 16r8F)
		)
		
		(PUSH
			(OppR 16r50)
			(OpRm 16rFF)
			(OpS8 16r6A)
			(OpIw 16r68)
		)
		
		(RET
			(Op 16rC3 )
			(OpU16 16rC2)
		)
	)
]

{ #category : #parsing }
SAsmX86Instructions class >> parseInstructionDescription: description [
	| mnemonic variants template |
	mnemonic := description first.
	variants := description allButFirst.
	(self hasClassVarNamed: mnemonic) ifFalse: [ 
		self addClassVarNamed: mnemonic.
	].

	template := SAsmX86InstructionTemplate new name: mnemonic.
	template alternatives: (variants collect: [:variant | self parseInstructionVariant: variant ]).
	self classVarNamed: mnemonic put: template
	
]

{ #category : #parsing }
SAsmX86Instructions class >> parseInstructionTable: table [
	table do: [ :desc | self parseInstructionDescription: desc ]
]

{ #category : #parsing }
SAsmX86Instructions class >> parseInstructionVariant: variant [
	| encodingName opcode encodingClass |
	encodingName := variant first.
	opcode := variant second.
	opcode isArray ifFalse: [ opcode := { opcode } ].
	encodingClass := Smalltalk globals at: (#SAsmX86Instruction , encodingName) asSymbol.
	^ encodingClass new opcode: opcode; parameters: (variant allButFirst: 2).
]
