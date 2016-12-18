"
Examples about the SAsm assembler.
"
Class {
	#name : #SAsmExamples,
	#superclass : #Object,
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

{ #category : #'see class side' }
SAsmExamples >> seeClassSide [
]
