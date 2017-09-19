Extension { #name : #'SAsmCompilationTargetX86_64' }

{ #category : #'*SAsm-DWARF' }
SAsmCompilationTargetX86_64 >> mapRegisterToDwarf: aRegister [
	^ SAsmDWX86RegisterMaps X86_64RegisterMap at: aRegister
]
