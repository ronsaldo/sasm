Class {
	#name : #SAsmMachOSymTabCommand,
	#superclass : #SAsmMachOLoadCommandHeader,
	#instVars : [
		'symoff',
		'nsyms',
		'stroff',
		'strsize',
		'content'
	],
	#category : #'SAsm-Core-MachO'
}

{ #category : #accessing }
SAsmMachOSymTabCommand >> content [
	^ content
]

{ #category : #accessing }
SAsmMachOSymTabCommand >> content: anObject [
	content := anObject
]

{ #category : #initialization }
SAsmMachOSymTabCommand >> initialize [
	super initialize.
	cmd := LC_SYMTAB.
	cmdsize := self size.
	symoff := 0.
	nsyms := 0.
	stroff := 0.
	strsize := 0.
]

{ #category : #accessing }
SAsmMachOSymTabCommand >> nsyms [
	^ nsyms
]

{ #category : #accessing }
SAsmMachOSymTabCommand >> nsyms: anObject [
	nsyms := anObject
]

{ #category : #writing }
SAsmMachOSymTabCommand >> prepareForWritingToFile [
	super prepareForWritingToFile.
	content ifNil: [ ^ self ].
	
	symoff := content fileOffset.
	nsyms := content symbolCount.
	stroff := content stringTable fileOffset.
	strsize := content stringTable fileSize.
]

{ #category : #accessing }
SAsmMachOSymTabCommand >> size [
	^ 24
]

{ #category : #accessing }
SAsmMachOSymTabCommand >> stroff [
	^ stroff
]

{ #category : #accessing }
SAsmMachOSymTabCommand >> stroff: anObject [
	stroff := anObject
]

{ #category : #accessing }
SAsmMachOSymTabCommand >> strsize [
	^ strsize
]

{ #category : #accessing }
SAsmMachOSymTabCommand >> strsize: anObject [
	strsize := anObject
]

{ #category : #accessing }
SAsmMachOSymTabCommand >> symoff [
	^ symoff
]

{ #category : #accessing }
SAsmMachOSymTabCommand >> symoff: anObject [
	symoff := anObject
]

{ #category : #writing }
SAsmMachOSymTabCommand >> writeOn: aStream [
	aStream
		nextPutInt32: cmd;
		nextPutInt32: cmdsize;
		nextPutInt32: symoff;
		nextPutInt32: nsyms;
		nextPutInt32: stroff;
		nextPutInt32: strsize
]
