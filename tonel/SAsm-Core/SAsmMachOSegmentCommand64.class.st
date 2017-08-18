Class {
	#name : #SAsmMachOSegmentCommand64,
	#superclass : #SAsmMachOSegmentCommand,
	#category : #'SAsm-Core-MachO'
}

{ #category : #'as yet unclassified' }
SAsmMachOSegmentCommand64 >> headerSize [
	^ 72
]

{ #category : #initialization }
SAsmMachOSegmentCommand64 >> initialize [
	super initialize.
	cmd := LC_SEGMENT_64.
]

{ #category : #writing }
SAsmMachOSegmentCommand64 >> writeOn: aStream [
	aStream
		nextPutInt32: cmd;
		nextPutInt32: cmdsize;
		nextPutAll: segname;
		nextPutInt64: vmaddr;
		nextPutInt64: vmsize;
		nextPutInt64: fileoff;
		nextPutInt64: filesize;
		nextPutInt32: maxprot;
		nextPutInt32: initprot;
		nextPutInt32: nsects;
		nextPutInt32: flags.
	sections do: [ :sect | sect writeOn: aStream ].
]
