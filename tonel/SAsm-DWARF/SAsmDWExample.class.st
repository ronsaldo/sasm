Class {
	#name : #SAsmDWExample,
	#superclass : #Object,
	#pools : [
		'SAsmDWConstants'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #'as yet unclassified' }
SAsmDWExample >> simpleCompileUnit [
	"
	self new simpleCompileUnit
	
	Test with:
	objdump --dwarf=info dwarf.o
	
	"
	| module intType asm |
	module := SAsmModule x86.
	module buildDWCompileUnit: [ :compileUnit :builder |
		intType := builder baseType: [ :type |
			type name: #int; byteSize: 4; encodingUnsigned
		].

		builder subprogram: [ :subprogram |
			subprogram name: #main.
		
			builder formalParameter: [ :param |
				param name: #argc; type: intType
			].
		].
	].

	asm := module asInstructionStream.
	asm asBinaryObject writeElfToFileNamed: 'dwarf.o'
]
