Extension { #name : #SAsmModule }

{ #category : #'*SAsm-DWARF' }
SAsmModule >> buildDWCompileUnit: aBlock [
	| debugInfo |
	debugInfo := SAsmDWModuleCompilationUnit new target: target; yourself.
	self addElement: debugInfo.
	^ debugInfo build: aBlock
]
