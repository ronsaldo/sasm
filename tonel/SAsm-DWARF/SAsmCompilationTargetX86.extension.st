Extension { #name : #SAsmCompilationTargetX86 }

{ #category : #'*SAsm-DWARF' }
SAsmCompilationTargetX86 >> mapRegisterToDwarf: aRegister [
	^ SAsmDWX86RegisterMaps I386RegisterMap at: aRegister
]
