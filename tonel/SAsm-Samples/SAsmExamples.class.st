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

{ #category : #'see class side' }
SAsmExamples >> seeClassSide [
]
