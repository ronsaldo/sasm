Class {
	#name : #'SAsmCompilationTargetX86_64',
	#superclass : #SAsmCompilationTarget,
	#classVars : [
		'R_X86_64_16',
		'R_X86_64_32',
		'R_X86_64_32S',
		'R_X86_64_64',
		'R_X86_64_8',
		'R_X86_64_COPY',
		'R_X86_64_DTPMOD64',
		'R_X86_64_DTPOFF32',
		'R_X86_64_DTPOFF64',
		'R_X86_64_GLOB_DAT',
		'R_X86_64_GOT32',
		'R_X86_64_GOTOFF64',
		'R_X86_64_GOTPC32',
		'R_X86_64_GOTPC32_TLSDESC',
		'R_X86_64_GOTPCREL',
		'R_X86_64_GOTTPOFF',
		'R_X86_64_IRELATIVE',
		'R_X86_64_JUMP_SLOT',
		'R_X86_64_NONE',
		'R_X86_64_PC16',
		'R_X86_64_PC32',
		'R_X86_64_PC64',
		'R_X86_64_PC8',
		'R_X86_64_PLT32',
		'R_X86_64_RELATIVE',
		'R_X86_64_SIZE32',
		'R_X86_64_SIZE64',
		'R_X86_64_TLSDESC',
		'R_X86_64_TLSDESC_CALL',
		'R_X86_64_TLSGD',
		'R_X86_64_TLSLD',
		'R_X86_64_TPOFF32',
		'R_X86_64_TPOFF64'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'class initialization' }
SAsmCompilationTargetX86_64 class >> initialize [
	super initialize.
	
	self initializeElfRelocations.
]

{ #category : #initialization }
SAsmCompilationTargetX86_64 class >> initializeElfRelocations [

	R_X86_64_NONE := 0.
	R_X86_64_64 := 1.
	R_X86_64_PC32 := 2.
	R_X86_64_GOT32 := 3.
	R_X86_64_PLT32 := 4.
	R_X86_64_COPY := 5.
	R_X86_64_GLOB_DAT := 6.
	R_X86_64_JUMP_SLOT := 7.
	R_X86_64_RELATIVE := 8.
	R_X86_64_GOTPCREL := 9.
	R_X86_64_32 := 10.
	R_X86_64_32S := 11.
	R_X86_64_16 := 12.
	R_X86_64_PC16 := 13.
	R_X86_64_8 := 14.
	R_X86_64_PC8 := 15.
	R_X86_64_DTPMOD64 := 16.
	R_X86_64_DTPOFF64 := 17.
	R_X86_64_TPOFF64 := 18.
	R_X86_64_TLSGD := 19.
	R_X86_64_TLSLD := 20.
	R_X86_64_DTPOFF32 := 21.
	R_X86_64_GOTTPOFF := 22.
	R_X86_64_TPOFF32 := 23.
	R_X86_64_PC64 := 24.
	R_X86_64_GOTOFF64 := 25.
	R_X86_64_GOTPC32 := 26.
	R_X86_64_SIZE32 := 32.
	R_X86_64_SIZE64 := 33.
	R_X86_64_GOTPC32_TLSDESC := 34.
	R_X86_64_TLSDESC_CALL := 35.
	R_X86_64_TLSDESC := 36.
	R_X86_64_IRELATIVE := 37.
]

{ #category : #'elf relocations' }
SAsmCompilationTargetX86_64 >> convertRelocation: relocation section: section elfBuilder: elfBuilder [
	| table elfReloc symbolIndex |
	table := elfBuilder relocationWithAddendSectionFor: section.
	relocation clearImplicitAddendIn: section.
	
	elfReloc := table newEntry.
	symbolIndex := elfBuilder indexOfRelocationSymbol: relocation symbol section: (elfBuilder sectionFromContent: relocation section).
	elfReloc
		offset: relocation offset;
		addend: relocation addend.
	relocation isAbsoluteOffset32 ifTrue: [
		^ elfReloc symbol: symbolIndex type: R_X86_64_32
	].
	relocation isRelativeSOffset32 ifTrue: [
		^ elfReloc symbol: symbolIndex type: R_X86_64_PC32
	].
	relocation isAbsoluteOffset64 ifTrue: [
		^ elfReloc symbol: symbolIndex type: R_X86_64_64
	].
	relocation isRelativeSOffset64 ifTrue: [
		^ elfReloc symbol: symbolIndex type: R_X86_64_PC64
	].
	self halt.
	

]

{ #category : #'elf constants' }
SAsmCompilationTargetX86_64 >> elfMachine [
	^ 16r3E
]

{ #category : #accessing }
SAsmCompilationTargetX86_64 >> pointerSize [
	^ 8
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86_64 >> setupBinaryObjectWriter: writer [
	writer cpuMode: #long
]

{ #category : #accessing }
SAsmCompilationTargetX86_64 >> usesElf64 [
	^ true
]
