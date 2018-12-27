Class {
	#name : #'SAsmElfX86_64MachineRelocationParser',
	#superclass : #SAsmElfMachineRelocationParser,
	#classVars : [
		'ElfRelocationTypeMap'
	],
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'as yet unclassified' }
SAsmElfX86_64MachineRelocationParser class >> initialize [
	super initialize.
	R_X86_64_16 ifNil: [ SAsmX86Constants initialize ].
	
	ElfRelocationTypeMap := Dictionary newFromPairs: {
		R_X86_64_32 . [ :this :elfRelocation :relocation | this convertR_X86_64_32: elfRelocation into: relocation ].
		R_X86_64_32S . [ :this :elfRelocation :relocation | this convertR_X86_64_32S: elfRelocation into: relocation ].
		R_X86_64_64 . [ :this :elfRelocation :relocation | this convertR_X86_64_64: elfRelocation into: relocation ].
		R_X86_64_PLT32 . [ :this :elfRelocation :relocation | this convertR_X86_64_PLT32: elfRelocation into: relocation ].
		R_X86_64_PC32 . [ :this :elfRelocation :relocation | this convertR_X86_64_PC32: elfRelocation into: relocation ].
		R_X86_64_PC64 . [ :this :elfRelocation :relocation | this convertR_X86_64_PC64: elfRelocation into: relocation ].
		R_X86_64_GOTPCREL . [ :this : elfRelocation :relocation | this convertR_X86_64_GOTPCREL: elfRelocation into: relocation ].
	}.
]

{ #category : #'as yet unclassified' }
SAsmElfX86_64MachineRelocationParser class >> machineType [
	^ 16r3E
]

{ #category : #'elf relocations' }
SAsmElfX86_64MachineRelocationParser >> compilationTargetForElfHeader: elfHeader [
	^ SAsmModule x86_64

]

{ #category : #'elf relocations' }
SAsmElfX86_64MachineRelocationParser >> convertElfRelocation: elfRelocation typeInto: relocation [
	| type |
	type := elfRelocation type.
	(ElfRelocationTypeMap at: type ifAbsent: [ self error: 'Unsupported elf relocation' ])
		value: self value: elfRelocation value: relocation
]

{ #category : #'elf relocations' }
SAsmElfX86_64MachineRelocationParser >> convertR_X86_64_32: elfRelocation into: relocation [
	relocation absoluteOffset32
]

{ #category : #'elf relocations' }
SAsmElfX86_64MachineRelocationParser >> convertR_X86_64_32S: elfRelocation into: relocation [
	relocation absoluteSOffset32
]

{ #category : #'elf relocations' }
SAsmElfX86_64MachineRelocationParser >> convertR_X86_64_64: elfRelocation into: relocation [
	relocation absoluteOffset64
]

{ #category : #'elf relocations' }
SAsmElfX86_64MachineRelocationParser >> convertR_X86_64_GOTPCREL: elfRelocation into: relocation [
	relocation relativeSOffset32AtGOT
]

{ #category : #'elf relocations' }
SAsmElfX86_64MachineRelocationParser >> convertR_X86_64_PC32: elfRelocation into: relocation [
	relocation relativeSOffset32
]

{ #category : #'elf relocations' }
SAsmElfX86_64MachineRelocationParser >> convertR_X86_64_PLT32: elfRelocation into: relocation [
	relocation relativeBranch32
]
