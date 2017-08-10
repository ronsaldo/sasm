Class {
	#name : #SAsmMachOHeader64,
	#superclass : #SAsmMachOHeader32,
	#category : #'SAsm-Core-MachO'
}

{ #category : #accessing }
SAsmMachOHeader64 >> size [
	^ 32
]

{ #category : #writing }
SAsmMachOHeader64 >> writeOn: aStream [
	aStream
		nextPutInt32: magic;
		nextPutInt32: cputype;
		nextPutInt32: cpusubtype;
		nextPutInt32: filetype;
		nextPutInt32: ncmds;
		nextPutInt32: sizeofcmds;
		nextPutInt32: flags;
		nextPutInt32: 0 "reserved"

]
