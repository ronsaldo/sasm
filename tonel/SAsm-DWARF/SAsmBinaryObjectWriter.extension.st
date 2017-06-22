Extension { #name : #SAsmBinaryObjectWriter }

{ #category : #'*SAsm-DWARF' }
SAsmBinaryObjectWriter >> writeDWDebugLines [
	SAsmDWDebugLineWriter new writeSourceLocations: debugSourceLocationsList with: self
]
