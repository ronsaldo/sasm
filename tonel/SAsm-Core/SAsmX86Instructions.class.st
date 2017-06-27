Class {
	#name : #SAsmX86Instructions,
	#superclass : #SharedPool,
	#classVars : [
		'ADC',
		'ADD',
		'AND',
		'CALL',
		'CLD',
		'CMP',
		'CMPXCHG',
		'DIV',
		'IDIV',
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
		'LEA',
		'LOCK',
		'MOV',
		'MOVSX',
		'MOVSXD',
		'MOVS_B',
		'MOVS_D',
		'MOVS_Q',
		'MOVZX',
		'NEG',
		'NOT',
		'OR',
		'POP',
		'PUSH',
		'REP',
		'RET',
		'SAL',
		'SAR',
		'SHL',
		'SHR',
		'SUB',
		'TEST',
		'XADD',
		'XCHG',
		'XOR'
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

		(CLD
			(Op 16rFC)
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
		
		(CMPXCHG
			(OpRmbRb (16r0F 16rB0))
			(OpRmwRw (16r0F 16rB1))
		)
		
		(DIV
			(OpRmbOp 16rF6 6)
			(OpRmwOp 16rF7 6)
		)
		
		(IDIV
			(OpRmbOp 16rF6 7)
			(OpRmwOp 16rF7 7)
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
		
		(LEA
			(OpRwRmw 16r8D)
		)
		
		(LOCK
			(Op 16rF0)
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
		
		(MOVSX
			(OpRwRmb #(16r0F 16rBE))
			(OpRwRmw #(16r0F 16rBF))
		)
		(MOVSXD
			(OpRwRmw 16r63)
		)
		(MOVZX
			(OpRwRmb #(16r0F 16rB6))
			(OpRwRmw #(16r0F 16rB7))
		)
		
		(MOVS_B
			(Op 16rA4)
		)
		(MOVS_D
			(Op 16rA5)
		)
		(MOVS_Q
			(RexWOp 16rA5)
		)
		
		(NEG
			(OpRmbOp 16rF6 3)
			(OpRmwOp 16rF7 3)
		)

		(NOT
			(OpRmbOp 16rF6 2)
			(OpRmwOp 16rF7 2)
		)

		(OR
			(OpALI8 16r0C)
			(OpAXIw 16r0D)

			(OpRmbIb 16r80 1)
			
			(OpRmwS8 16r83 1)
			(OpRmwIw 16r81 1)
			
			(OpRmbRb 16r08)
			(OpRmwRw 16r09)
			(OpRbRmb 16r0A)
			(OpRwRmw 16r0B)
		)
		
		(POP
			(OppR 16r58)
			(OpRm 16r8F 0)
		)
		
		(PUSH
			(OppR 16r50)
			(OpRm 16rFF 6)
			(OpS8 16r6A)
			(OpIw 16r68)
		)
		
		(REP
			(Op 16rF3)
		)
				
		(RET
			(Op 16rC3 )
			(OpU16 16rC2)
		)
		
		(SHL
			(OpRmbI_1 16rD0 4)
			(OpRmbIb 16rC0 4)
			(OpRmbCL 16rD2 4)
			(OpRmwI_1 16rD1 4)
			(OpRmwIb 16rC1 4)
			(OpRmwCL 16rD3 4)
		)

		(SAL
			(OpRmbI_1 16rD0 4)
			(OpRmbIb 16rC0 4)
			(OpRmbCL 16rD2 4)
			(OpRmwI_1 16rD1 4)
			(OpRmwIb 16rC1 4)
			(OpRmwCL 16rD3 4)
		)

		(SHR
			(OpRmbI_1 16rD0 5)
			(OpRmbIb 16rC0 5)
			(OpRmbCL 16rD2 5)
			(OpRmwI_1 16rD1 5)
			(OpRmwIb 16rC1 5)
			(OpRmwCL 16rD3 5)
		)

		(SAR
			(OpRmbI_1 16rD0 7)
			(OpRmbIb 16rC0 7)
			(OpRmbCL 16rD2 7)
			(OpRmwI_1 16rD1 7)
			(OpRmwIb 16rC1 7)
			(OpRmwCL 16rD3 7)
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
		
		(XADD
			(OpRmbRb (16r0F 16rC0))
			(OpRmwRw (16r0F 16rC1))
		)
		
		(XCHG
			(OppR 16r90)
			(OpRmbRb 16r86)
			(OpRmwRw 16r87)

			(OpRbRmb 16r86)
			(OpRwRmw 16r87)
		)

		(XOR
			(OpALI8 16r34)
			(OpAXIw 16r35)

			(OpRmbIb 16r80 6)
			
			(OpRmwS8 16r83 6)
			(OpRmwIw 16r81 6)
			
			(OpRmbRb 16r30)
			(OpRmwRw 16r31)
			(OpRbRmb 16r32)
			(OpRwRmw 16r33)
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
