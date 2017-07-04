"
Examples about the SAsm assembler.
"
Class {
	#name : #SAsmExamples,
	#superclass : #Object,
	#pools : [
		'SAsmX86Constants',
		'SAsmX86Instructions'
	],
	#category : #'SAsm-Samples'
}

{ #category : #'basic examples' }
SAsmExamples class >> exampleFunctionWithConstants [
	<example>
	| module entry function |
	module := SAsmModule new.
	function := module build: #main function: [ :functionBuilder |
		entry := functionBuilder basicBlock: #entry build: [ :asm |
			asm
				constI32: 0;
				constI16: 1;
				constI8: 2
		]
	].
	module inspect
	
]

{ #category : #'tac examples' }
SAsmExamples class >> exampleTacAdd [
	<example>
	| module entry function a b result |
	module := SAsmModule x86.
	function := module build: #main function: [ :functionBuilder |
		entry := functionBuilder basicBlock: #entry build: [ :asm |
			a := asm tacIntRegister.
			b := asm tacIntRegister.
			result := asm tacIntRegister.
			
			asm
				tacMove: 1 into: a;
				tacMove: 2 into: b;
				tacAdd: a with: b into: result;
				tacReturn: result
		]
	].
	module inspect
	
]

{ #category : #'tac examples' }
SAsmExamples class >> exampleTacMax [
	<example>
	| module function a b condition returnA returnB |
	module := SAsmModule x86.
	function := module build: #max function: [ :functionBuilder |
		a := functionBuilder tacIntArgument: #a.
		b := functionBuilder tacIntArgument: #b.

		functionBuilder basicBlock: #entry build: [ :asm |
			condition := asm tacBoolRegister.
			returnA := functionBuilder basicBlock: #returnA.
			returnB := functionBuilder basicBlock: #returnB.
			asm
				tacGreater: a with: b into: condition;
				tacBranch: condition true: returnA false: returnB
		].

		returnA build: [ :asm |
			asm tacReturn: a
		].
		returnB build: [ :asm |
			asm tacReturn: b
		].
	].
	module inspect
	
]

{ #category : #'tac examples' }
SAsmExamples class >> exampleTacMin [
	<example>
	| module function a b condition returnA returnB |
	module := SAsmModule x86.
	function := module build: #min function: [ :functionBuilder |
		a := functionBuilder tacIntArgument: #a.
		b := functionBuilder tacIntArgument: #b.

		functionBuilder basicBlock: #entry build: [ :asm |
			condition := asm tacBoolRegister.
			returnA := functionBuilder basicBlock: #returnA.
			returnB := functionBuilder basicBlock: #returnB.
			asm
				tacLess: a with: b into: condition;
				tacBranch: condition true: returnA false: returnB
		].

		returnA build: [ :asm |
			asm tacReturn: a
		].
		returnB build: [ :asm |
			asm tacReturn: b
		].
	].
	module inspect
	
]

{ #category : #'tac examples' }
SAsmExamples class >> exampleTacRet0 [
	<example>
	| module entry function |
	module := SAsmModule x86.
	function := module build: #main function: [ :functionBuilder |
		entry := functionBuilder basicBlock: #entry build: [ :asm |
			asm tacReturn: 0
		]
	].
	module inspect
	
]

{ #category : #'x86 examples' }
SAsmExamples class >> exampleX86FunctionCall [
	<example>
	| module add main |
	module := SAsmModule x86.

	add := module build: #add function: [ :functionBuilder |
		functionBuilder naked.
		functionBuilder basicBlock: #entry build: [ :asm |
			asm
				x86: ADD dst: EAX src: EBX;
				x86: RET
		]
	].
	
	main := module build: #main function: [ :functionBuilder |
		functionBuilder naked.
		functionBuilder basicBlock: #entry build: [ :asm |
			asm
				x86: MOV dst: EAX src: 2;
				x86: MOV dst: EBX src: 4;
				x86: CALL with: add;
				x86: RET
		]
	].
	module inspect
	
]

{ #category : #'x86 examples' }
SAsmExamples class >> exampleX86FunctionFrame [
	<example>
	| module entry function |
	module := SAsmModule x86.
	function := module build: #main function: [ :functionBuilder |
		functionBuilder naked.
		entry := functionBuilder basicBlock: #entry build: [ :asm |
			asm
				x86: PUSH with: EBP;
				x86: MOV dst: EBP src: ESP;
				
				x86: MOV dst: ESP src: EBP;
				x86: POP with: EBP;
				x86: RET
		]
	].
	module inspect
	
]

{ #category : #'x86 examples' }
SAsmExamples class >> exampleX86Ret0 [
	<example>
	| module entry function |
	module := SAsmModule x86.
	function := module build: #main function: [ :functionBuilder |
		functionBuilder naked.
		entry := functionBuilder basicBlock: #entry build: [ :asm |
			asm
				x86: MOV with: EAX with: 0;
				x86: RET
		]
	].
	module inspect
	
]

{ #category : #'x86 64 examples' }
SAsmExamples class >> exampleX86_64FunctionCall [
	<example>
	| module add main |
	module := SAsmModule x86_64.

	add := module build: #add function: [ :functionBuilder |
		functionBuilder naked.
		functionBuilder basicBlock: #entry build: [ :asm |
			asm
				x86: ADD dst: RAX src: RBX;
				x86: RET
		]
	].
	
	main := module build: #main function: [ :functionBuilder |
		functionBuilder naked.
		functionBuilder basicBlock: #entry build: [ :asm |
			asm
				x86: MOV dst: RAX src: 2;
				x86: MOV dst: RBX src: 4;
				x86: CALL with: add;
				x86: RET
		]
	].
	module inspect
	
]

{ #category : #'x86 64 examples' }
SAsmExamples class >> exampleX86_64FunctionFrame [
	<example>
	| module entry function |
	module := SAsmModule x86_64.
	function := module build: #main function: [ :functionBuilder |
		functionBuilder naked.
		entry := functionBuilder basicBlock: #entry build: [ :asm |
			asm
				x86: PUSH with: RBP;
				x86: MOV dst: RBP src: RSP;
				
				x86: MOV dst: RSP src: RBP;
				x86: POP with: RBP;
				x86: RET
		]
	].
	module inspect
	
]

{ #category : #'x86 64 examples' }
SAsmExamples class >> exampleX86_64Ret0 [
	<example>
	| module entry function |
	module := SAsmModule x86_64.
	function := module build: #main function: [ :functionBuilder |
		functionBuilder naked.
		entry := functionBuilder basicBlock: #entry build: [ :asm |
			asm
				x86: MOV with: RAX with: 0;
				x86: RET
		]
	].
	module inspect
	
]

{ #category : #'x86 64 examples' }
SAsmExamples class >> exampleX86_64SSE [
	<example>
	| module entry function |
	module := SAsmModule x86_64.
	function := module build: #main function: [ :functionBuilder |
		functionBuilder naked.
		entry := functionBuilder basicBlock: #entry build: [ :asm |
			asm
				x86: MOVAPD dst: XMM0 src: XMM15;
				x86: MOVAPS dst: XMM1 src: XMM14;
				x86: MOVSD dst: XMM2 src: XMM13;
				x86: MOVSS dst: XMM3 src: XMM12;

				x86: ADDPD dst: XMM0 src: XMM15;
				x86: ADDPS dst: XMM1 src: XMM14;
				x86: ADDSD dst: XMM2 src: XMM13;
				x86: ADDSS dst: XMM3 src: XMM12;

				x86: SUBPD dst: XMM0 src: XMM15;
				x86: SUBPS dst: XMM1 src: XMM14;
				x86: SUBSD dst: XMM2 src: XMM13;
				x86: SUBSS dst: XMM3 src: XMM12;

				x86: MULPD dst: XMM0 src: XMM15;
				x86: MULPS dst: XMM1 src: XMM14;
				x86: MULSD dst: XMM2 src: XMM13;
				x86: MULSS dst: XMM3 src: XMM12;

				x86: DIVPD dst: XMM0 src: XMM15;
				x86: DIVPS dst: XMM1 src: XMM14;
				x86: DIVSD dst: XMM2 src: XMM13;
				x86: DIVSS dst: XMM3 src: XMM12;

				x86: SQRTPD dst: XMM0 src: XMM15;
				x86: SQRTPS dst: XMM1 src: XMM14;
				x86: SQRTSD dst: XMM2 src: XMM13;
				x86: SQRTSS dst: XMM3 src: XMM12;

				x86: ANDPD dst: XMM2 src: XMM13;
				x86: ANDPS dst: XMM3 src: XMM12;

				x86: ANDNPD dst: XMM2 src: XMM13;
				x86: ANDNPS dst: XMM3 src: XMM12;

				x86: ORPD dst: XMM2 src: XMM13;
				x86: ORPS dst: XMM3 src: XMM12;

				x86: XORPD dst: XMM2 src: XMM13;
				x86: XORPS dst: XMM3 src: XMM12;

				x86: SHUFPD dst: XMM0 src: XMM15 with: 16r77;
				x86: SHUFPS dst: XMM1 src: XMM14 with: 16r77;

				x86: RET
		]
	].
	module inspect
	
]

{ #category : #'see class side' }
SAsmExamples >> seeClassSide [
]
