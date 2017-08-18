Class {
	#name : #SAsmX86Instructions,
	#superclass : #SharedPool,
	#classVars : [
		'ADC',
		'ADD',
		'ADDPD',
		'ADDPS',
		'ADDSD',
		'ADDSS',
		'AND',
		'ANDNPD',
		'ANDNPS',
		'ANDPD',
		'ANDPS',
		'CALL',
		'CLD',
		'CMP',
		'CMPPD',
		'CMPPS',
		'CMPSD',
		'CMPSS',
		'CMPXCHG',
		'COMISD',
		'COMISS',
		'CVTDQ2PD',
		'CVTDQ2PS',
		'CVTPD2DQ',
		'CVTPD2PS',
		'CVTPS2DQ',
		'CVTPS2PD',
		'CVTSD2SI',
		'CVTSD2SS',
		'CVTSI2SD',
		'CVTSI2SS',
		'CVTSS2SD',
		'CVTSS2SI',
		'DIV',
		'DIVPD',
		'DIVPS',
		'DIVSD',
		'DIVSS',
		'FLD',
		'FST',
		'FSTP',
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
		'MOVAPD',
		'MOVAPS',
		'MOVSD',
		'MOVSS',
		'MOVSX',
		'MOVSXD',
		'MOVS_B',
		'MOVS_D',
		'MOVS_Q',
		'MOVZX',
		'MULPD',
		'MULPS',
		'MULSD',
		'MULSS',
		'NEG',
		'NOP',
		'NOT',
		'OR',
		'ORPD',
		'ORPS',
		'POP',
		'PUSH',
		'RCL',
		'RCR',
		'REP',
		'RET',
		'ROL',
		'ROR',
		'SAL',
		'SAR',
		'SHL',
		'SHR',
		'SHUFPD',
		'SHUFPS',
		'SQRTPD',
		'SQRTPS',
		'SQRTSD',
		'SQRTSS',
		'SUB',
		'SUBPD',
		'SUBPS',
		'SUBSD',
		'SUBSS',
		'TEST',
		'UCOMISD',
		'UCOMISS',
		'XADD',
		'XCHG',
		'XOR',
		'XORPD',
		'XORPS'
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
			(OpBranch32 16rE8)
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
			(OpBranch32 16rE9)
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
		
		(MOVAPD
			(OpRxRmx (16r0f 16r28) (16r66))
			(OpRmxRx (16r0f 16r29) (16r66))
		)
		
		(MOVAPS
			(OpRxRmx (16r0f 16r28))
			(OpRmxRx (16r0f 16r29))
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
		
		(NOP
			(Op 16r90)
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

		(RCL
			(OpRmbI_1 16rD0 2)
			(OpRmbIb 16rC0 2)
			(OpRmbCL 16rD2 2)
			(OpRmwI_1 16rD1 2)
			(OpRmwIb 16rC1 2)
			(OpRmwCL 16rD3 2)
		)
		(RCR
			(OpRmbI_1 16rD0 3)
			(OpRmbIb 16rC0 3)
			(OpRmbCL 16rD2 3)
			(OpRmwI_1 16rD1 3)
			(OpRmwIb 16rC1 3)
			(OpRmwCL 16rD3 3)
		)

		(ROL
			(OpRmbI_1 16rD0 0)
			(OpRmbIb 16rC0 0)
			(OpRmbCL 16rD2 0)
			(OpRmwI_1 16rD1 0)
			(OpRmwIb 16rC1 0)
			(OpRmwCL 16rD3 0)
		)
		(ROR
			(OpRmbI_1 16rD0 1)
			(OpRmbIb 16rC0 1)
			(OpRmbCL 16rD2 1)
			(OpRmwI_1 16rD1 1)
			(OpRmwIb 16rC1 1)
			(OpRmwCL 16rD3 1)
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
		
		"x87 FPU"
		(FLD
			(OpM32fp 16rD9 0)
			(OpM64fp 16rDD 0)
			(OpM80fp 16rDB 5)
		)

		(FST
			(OpM32fp 16rD9 2)
			(OpM64fp 16rDD 2)
		)
		(FSTP
			(OpM32fp 16rD9 3)
			(OpM64fp 16rDD 3)
			(OpM80fp 16rDB 7)
		)

		"SSE instructions"
		(ADDPD
			(OpRxRmx (16r0F 16r58) (16r66))
		)
		(ADDPS
			(OpRxRmx (16r0F 16r58))
		)
		(ADDSD
			(OpRxRmx (16r0F 16r58) (16rf2))
		)
		(ADDSS
			(OpRxRmx (16r0F 16r58) (16rf3))
		)

		(ANDPD
			(OpRxRmx (16r0F 16r54) (16r66))
		)
		(ANDPS
			(OpRxRmx (16r0F 16r54))
		)

		(ANDNPD
			(OpRxRmx (16r0F 16r55) (16r66))
		)
		(ANDNPS
			(OpRxRmx (16r0F 16r55))
		)

		(CMPPD
			(OpRxRmxI8 (16r0F 16rC2) (16r66))
		)
		(CMPPS
			(OpRxRmxI8 (16r0F 16rC2))
		)
		(CMPSD
			(OpRxRmxI8 (16r0F 16rC2) (16rF2))
		)
		(CMPSS
			(OpRxRmxI8 (16r0F 16rC2) (16rF3))
		)

		(COMISD
			(OpRxRmx (16r0F 16r2F) (16r66))
		)
		(COMISS
			(OpRxRmx (16r0F 16r2F))
		)


		(CVTDQ2PD
			(OpRxRmx (16r0F 16rE6) (16rF3))
		)
		(CVTDQ2PS
			(OpRxRmx (16r0F 16r5B))
		)
		(CVTPD2DQ
			(OpRxRmx (16r0F 16rE6) (16rF2))
		)
		(CVTPD2PS
			(OpRxRmx (16r0F 16r5A) (16r66))
		)

		(CVTPS2DQ
			(OpRxRmx (16r0F 16r5B) (16r66))
		)

		(CVTPS2PD
			(OpRxRmx (16r0F 16r5A))
		)

		(CVTSD2SI
			(OpRwRmx (16r0F 16r2D) (16rF2))
		)
		(CVTSD2SS
			(OpRxRmx (16r0F 16r5A) (16rF2))
		)
		(CVTSI2SD
			(OpRxRmw (16r0F 16r2A) (16rF2))
		)
		(CVTSI2SS
			(OpRxRmw (16r0F 16r2A) (16rF3))
		)
		(CVTSS2SD
			(OpRxRmx (16r0F 16r5A) (16rF3))
		)
		(CVTSS2SI
			(OpRxRmx (16r0F 16r2D) (16rF3))
		)

		(DIVPD
			(OpRxRmx (16r0F 16r5e) (16r66))
		)
		(DIVPS
			(OpRxRmx (16r0F 16r5e))
		)
		(DIVSD
			(OpRxRmx (16r0F 16r5e) (16rf2))
		)
		(DIVSS
			(OpRxRmx (16r0F 16r5e) (16rf3))
		)
		
		(MOVSD
			(OpRxRmx (16r0f 16r10) (16rf2))
			(OpRmxRx (16r0f 16r11) (16rf2))
		)
		
		(MOVSS
			(OpRxRmx (16r0f 16r10) (16rf3))
			(OpRmxRx (16r0f 16r11) (16rf3))
		)

		(MULPD
			(OpRxRmx (16r0F 16r59) (16r66))
		)
		(MULPS
			(OpRxRmx (16r0F 16r59))
		)
		(MULSD
			(OpRxRmx (16r0F 16r59) (16rf2))
		)
		(MULSS
			(OpRxRmx (16r0F 16r59) (16rf3))
		)

		(ORPD
			(OpRxRmx (16r0F 16r56) (16r66))
		)
		(ORPS
			(OpRxRmx (16r0F 16r56))
		)
		
		(SHUFPD
			(OpRxRmxI8 (16r0f 16rc6) (16r66))
		)
		(SHUFPS
			(OpRxRmxI8 (16r0f 16rc6))
		)

		(SQRTPD
			(OpRxRmx (16r0F 16r51) (16r66))
		)
		(SQRTPS
			(OpRxRmx (16r0F 16r51))
		)
		(SQRTSD
			(OpRxRmx (16r0F 16r51) (16rf2))
		)
		(SQRTSS
			(OpRxRmx (16r0F 16r51) (16rf3))
		)

		(SUBPD
			(OpRxRmx (16r0F 16r5c) (16r66))
		)
		(SUBPS
			(OpRxRmx (16r0F 16r5c))
		)
		(SUBSD
			(OpRxRmx (16r0F 16r5c) (16rf2))
		)
		(SUBSS
			(OpRxRmx (16r0F 16r5c) (16rf3))
		)

		(UCOMISD
			(OpRxRmx (16r0F 16r2E) (16r66))
		)
		(UCOMISS
			(OpRxRmx (16r0F 16r2E))
		)
		
		(XORPD
			(OpRxRmx (16r0F 16r57) (16r66))
		)
		(XORPS
			(OpRxRmx (16r0F 16r57))
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
