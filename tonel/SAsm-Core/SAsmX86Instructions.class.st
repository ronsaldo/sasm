Class {
	#name : #SAsmX86Instructions,
	#superclass : #SharedPool,
	#classVars : [
		'ADC',
		'ADD',
		'AND',
		'CALL',
		'CMP',
		'IMUL',
		'IRET',
		'JA',
		'JAE',
		'JB',
		'JBE',
		'JC',
		'JE',
		'JG',
		'JGE',
		'JL',
		'JLE',
		'JMP',
		'JNC',
		'JNE',
		'JNO',
		'JNZ',
		'JO',
		'JZ',
		'MOV',
		'POP',
		'PUSH',
		'RET',
		'SUB',
		'TEST'
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
		(ADC
			(OpALI8 16r14)
			(OpAXIw 16r15)

			(OpRmbIb 16r80 2)
			
			(OpRmwS8 16r83 2)
			(OpRmwIw 16r81 2)
			
			(OpRmbRb 16r10)
			(OpRmwRw 16r11)
			(OpRbRmb 16r12)
			(OpRwRmw 16r13)
		)
		
		(ADD
			(OpALI8 16r04)
			(OpAXIw 16r05)

			(OpRmbIb 16r80 0)
			
			(OpRmwS8 16r83 0)
			(OpRmwIw 16r81 0)
			
			(OpRmbRb 16r00)
			(OpRmwRw 16r01)
			(OpRbRmb 16r02)
			(OpRwRmw 16r03)
		)
		
		(AND
			(OpALI8 16r24)
			(OpAXIw 16r25)

			(OpRmbIb 16r80 4)
			
			(OpRmwS8 16r83 4)
			(OpRmwIw 16r81 4)
			
			(OpRmbRb 16r20)
			(OpRmwRw 16r21)
			(OpRbRmb 16r22)
			(OpRwRmw 16r23)
		)
		
		(CALL
			(OpIrw 16rE8)
			(OpRm 16rFF 2)
		)

		(CMP
			(OpALI8 16r3C)
			(OpAXIw 16r3D)

			(OpRmbIb 16r80 7)
			
			(OpRmwS8 16r83 7)
			(OpRmwIw 16r81 7)
			
			(OpRmbRb 16r38)
			(OpRmwRw 16r39)
			(OpRbRmb 16r3A)
			(OpRwRmw 16r3B)
		)
		
		(IMUL
			(OpRwRmw #(16r0F 16rAF))
			(OpRwRmwI8 16r6B)
			(OpRwRmwIw 16r69)
		)
		
		(IRET
			(Op 16rCF)
		)
		
		(JO
			(OpIr8 16r70)
			(OpIrw #(16r0F 16r80))
		)
		(JNO
			(OpIr8 16r71)
			(OpIrw #(16r0F 16r81))
		)
		(JC
			(OpIr8 16r72)
			(OpIrw #(16r0F 16r82))
		)
		(JNC
			(OpIr8 16r73)
			(OpIrw #(16r0F 16r83))
		)
		(JA
			(OpIr8 16r77)
			(OpIrw #(16r0F 16r87))
		)
		(JAE
			(OpIr8 16r73)
			(OpIrw #(16r0F 16r83))
		)
		(JB
			(OpIr8 16r72)
			(OpIrw #(16r0F 16r82))
		)
		(JBE
			(OpIr8 16r76)
			(OpIrw #(16r0F 16r86))
		)
		
		(JL
			(OpIr8 16r7C)
			(OpIrw #(16r0F 16r8C))
		)
		(JLE
			(OpIr8 16r7E)
			(OpIrw #(16r0F 16r8E))
		)
		(JG
			(OpIr8 16r7F)
			(OpIrw #(16r0F 16r8F))
		)
		(JGE
			(OpIr8 16r7D)
			(OpIrw #(16r0F 16r8D))
		)

		(JE
			(OpIr8 16r74)
			(OpIrw #(16r0F 16r84))
		)
		(JZ
			(OpIr8 16r74)
			(OpIrw #(16r0F 16r84))
		)

		(JNE
			(OpIr8 16r75)
			(OpIrw #(16r0F 16r85))
		)
		(JNZ
			(OpIr8 16r75)
			(OpIrw #(16r0F 16r85))
		)
		
		(JMP
			(OpIr8 16rEB)
			(OpIrw 16rE9)
			(OpRm 16rFF 4)
		)

		(MOV
			(OppRbIb 16rB0 0)
			(OpRmqIsd 16rC7 0)
			(OppRwIww 16rB8)
			(OpRmbIb 16rC6 0)
			(OpRmwIw 16rC7 0)
			
			(OpRmbRb 16r88)
			(OpRmwRw 16r89)
			(OpRbRmb 16r8A)
			(OpRwRmw 16r8B)
		)
		
		(POP
			(OppR 16r58)
			(OpRm 16r8F 0)
		)
		
		(PUSH
			(OppR 16r50)
			(OpRm 16rFF 0)
			(OpS8 16r6A)
			(OpIw 16r68)
		)
		
		(RET
			(Op 16rC3 )
			(OpU16 16rC2)
		)
		
		(SUB
			(OpALI8 16r2C)
			(OpAXIw 16r2D)

			(OpRmbIb 16r80 5)
			
			(OpRmwS8 16r83 5)
			(OpRmwIw 16r81 5)
			
			(OpRmbRb 16r28)
			(OpRmwRw 16r29)
			(OpRbRmb 16r2A)
			(OpRwRmw 16r2B)
		)
		
		(TEST
			(OpALI8 16rA8)
			(OpAXIw 16rA9)

			(OpRmbIb 16rF6 0)
			(OpRmwIw 16rF7 0)
			
			(OpRmbRb 16r84)
			(OpRmwRw 16r85)
			(OpRbRmb 16r84)
			(OpRwRmw 16r85)
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
