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

{ #category : #'x86 examples' }
SAsmExamples class >> exampleX86FunctionFrame [
	<example>
	| module entry function |
	module := SAsmModule new.
	function := module build: #main function: [ :functionBuilder |
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
	module := SAsmModule new.
	function := module build: #main function: [ :functionBuilder |
		entry := functionBuilder basicBlock: #entry build: [ :asm |
			asm
				x86: MOV with: EAX with: 0;
				x86: RET
		]
	].
	module inspect
	
]

{ #category : #'see class side' }
SAsmExamples >> seeClassSide [
]
