Class {
	#name : #SAsmMachODySymTabCommand,
	#superclass : #SAsmMachOLoadCommandHeader,
	#instVars : [
		'ilocalsym',
		'nlocalsym',
		'iextdefsym',
		'nextdefsym',
		'iundefsym',
		'nundefsym',
		'tocoff',
		'ntoc',
		'modtaboff',
		'nmodtab',
		'extrefsymoff',
		'nextrefsyms',
		'indirectsymoff',
		'nindirectsyms',
		'extreloff',
		'nextrel',
		'locreloff',
		'nlocrel',
		'symbolTable'
	],
	#category : #'SAsm-Core-MachO'
}

{ #category : #accessing }
SAsmMachODySymTabCommand >> extrefsymoff [
	^ extrefsymoff
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> extrefsymoff: anObject [
	extrefsymoff := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> extreloff [
	^ extreloff
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> extreloff: anObject [
	extreloff := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> iextdefsym [
	^ iextdefsym
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> iextdefsym: anObject [
	iextdefsym := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> ilocalsym [
	^ ilocalsym
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> ilocalsym: anObject [
	ilocalsym := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> indirectsymoff [
	^ indirectsymoff
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> indirectsymoff: anObject [
	indirectsymoff := anObject
]

{ #category : #initialization }
SAsmMachODySymTabCommand >> initialize [
	super initialize.
	cmd := LC_DYSYMTAB.
	cmdsize := self size.
	
	ilocalsym := 0.
	nlocalsym := 0.
	iextdefsym := 0.
	nextdefsym := 0.
	iundefsym := 0.
	nundefsym := 0.
	tocoff := 0.
	ntoc := 0.
	modtaboff := 0.
	nmodtab := 0.
	extrefsymoff := 0.
	nextrefsyms := 0.
	indirectsymoff := 0.
	nindirectsyms := 0.
	extreloff := 0.
	nextrel := 0.
	locreloff := 0.
	nlocrel := 0.
	
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> iundefsym [
	^ iundefsym
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> iundefsym: anObject [
	iundefsym := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> locreloff [
	^ locreloff
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> locreloff: anObject [
	locreloff := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> modtaboff [
	^ modtaboff
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> modtaboff: anObject [
	modtaboff := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nextdefsym [
	^ nextdefsym
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nextdefsym: anObject [
	nextdefsym := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nextrefsyms [
	^ nextrefsyms
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nextrefsyms: anObject [
	nextrefsyms := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nextrel [
	^ nextrel
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nextrel: anObject [
	nextrel := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nindirectsyms [
	^ nindirectsyms
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nindirectsyms: anObject [
	nindirectsyms := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nlocalsym [
	^ nlocalsym
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nlocalsym: anObject [
	nlocalsym := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nlocrel [
	^ nlocrel
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nlocrel: anObject [
	nlocrel := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nmodtab [
	^ nmodtab
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nmodtab: anObject [
	nmodtab := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> ntoc [
	^ ntoc
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> ntoc: anObject [
	ntoc := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nundefsym [
	^ nundefsym
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> nundefsym: anObject [
	nundefsym := anObject
]

{ #category : #writing }
SAsmMachODySymTabCommand >> prepareForWritingToFile [
	super prepareForWritingToFile.
	
	symbolTable ifNil: [ ^ self ].

	ilocalsym := 0.
	nlocalsym := symbolTable localSymbols size.
	
	iextdefsym := nlocalsym.
	nextdefsym := symbolTable externalSymbols size.
	
	iundefsym := nlocalsym + nextdefsym.
	nundefsym := symbolTable undefinedSymbols size.
]

{ #category : #initialization }
SAsmMachODySymTabCommand >> size [
	^ 80
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> symbolTable [
	^ symbolTable
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> symbolTable: anObject [
	symbolTable := anObject
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> tocoff [
	^ tocoff
]

{ #category : #accessing }
SAsmMachODySymTabCommand >> tocoff: anObject [
	tocoff := anObject
]

{ #category : #initialization }
SAsmMachODySymTabCommand >> writeOn: aStream [
	aStream
		nextPutInt32: cmd;
		nextPutInt32: cmdsize;
		
		nextPutInt32: ilocalsym;
		nextPutInt32: nlocalsym;
		nextPutInt32: iextdefsym;
		nextPutInt32: nextdefsym;
		nextPutInt32: iundefsym;
		nextPutInt32: nundefsym;
		nextPutInt32: tocoff;
		nextPutInt32: ntoc;
		nextPutInt32: modtaboff;
		nextPutInt32: nmodtab;
		nextPutInt32: extrefsymoff;
		nextPutInt32: nextrefsyms;
		nextPutInt32: indirectsymoff;
		nextPutInt32: nindirectsyms;
		nextPutInt32: extreloff;
		nextPutInt32: nextrel;
		nextPutInt32: locreloff;
		nextPutInt32: nlocrel.
]
