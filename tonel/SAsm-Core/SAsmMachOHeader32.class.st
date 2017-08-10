Class {
	#name : #SAsmMachOHeader32,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'magic',
		'cputype',
		'cpusubtype',
		'filetype',
		'ncmds',
		'sizeofcmds',
		'flags'
	],
	#pools : [
		'SAsmMachConstants'
	],
	#category : #'SAsm-Core-MachO'
}

{ #category : #accessing }
SAsmMachOHeader32 >> cpusubtype [
	^ cpusubtype
]

{ #category : #accessing }
SAsmMachOHeader32 >> cpusubtype: anObject [
	cpusubtype := anObject
]

{ #category : #accessing }
SAsmMachOHeader32 >> cputype [
	^ cputype
]

{ #category : #accessing }
SAsmMachOHeader32 >> cputype: anObject [
	cputype := anObject
]

{ #category : #accessing }
SAsmMachOHeader32 >> filetype [
	^ filetype
]

{ #category : #accessing }
SAsmMachOHeader32 >> filetype: anObject [
	filetype := anObject
]

{ #category : #accessing }
SAsmMachOHeader32 >> flags [
	^ flags
]

{ #category : #accessing }
SAsmMachOHeader32 >> flags: anObject [
	flags := anObject
]

{ #category : #initialization }
SAsmMachOHeader32 >> initialize [
	super initialize.
	magic := 0.
	cputype := 0.
	cpusubtype := 0.
	filetype := 0.
	ncmds := 0.
	sizeofcmds := 0.
	flags := 0.
]

{ #category : #accessing }
SAsmMachOHeader32 >> magic [
	^ magic
]

{ #category : #accessing }
SAsmMachOHeader32 >> magic: anObject [
	magic := anObject
]

{ #category : #accessing }
SAsmMachOHeader32 >> ncmds [
	^ ncmds
]

{ #category : #accessing }
SAsmMachOHeader32 >> ncmds: anObject [
	ncmds := anObject
]

{ #category : #accessing }
SAsmMachOHeader32 >> size [
	^ 28
]

{ #category : #accessing }
SAsmMachOHeader32 >> sizeofcmds [
	^ sizeofcmds
]

{ #category : #accessing }
SAsmMachOHeader32 >> sizeofcmds: anObject [
	sizeofcmds := anObject
]

{ #category : #writing }
SAsmMachOHeader32 >> writeOn: aStream [
	aStream
		nextPutInt32: magic;
		nextPutInt32: cputype;
		nextPutInt32: cpusubtype;
		nextPutInt32: filetype;
		nextPutInt32: ncmds;
		nextPutInt32: sizeofcmds;
		nextPutInt32: flags

]
