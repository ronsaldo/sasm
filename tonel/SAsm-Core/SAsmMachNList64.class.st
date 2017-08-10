Class {
	#name : #SAsmMachNList64,
	#superclass : #SAsmMachNList,
	#pools : [
		'SAsmMachConstants'
	],
	#category : #'SAsm-Core-MachO'
}

{ #category : #'as yet unclassified' }
SAsmMachNList64 class >> entrySize [
	^ 16
]

{ #category : #writing }
SAsmMachNList64 >> writeOn: aStream [
	aStream
		nextPutInt32: n_strx;
		nextPutInt8: n_type;
		nextPutInt8: n_sect;
		nextPutInt16: n_desc;
		nextPutInt64: n_value
]
