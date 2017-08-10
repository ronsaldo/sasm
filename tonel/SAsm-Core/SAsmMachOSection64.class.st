Class {
	#name : #SAsmMachOSection64,
	#superclass : #SAsmMachOSection32,
	#category : #'SAsm-Core-MachO'
}

{ #category : #accessing }
SAsmMachOSection64 >> size [
	^ 80
]

{ #category : #writing }
SAsmMachOSection64 >> writeOn: aStream [
	aStream
		nextPutAll: sectname;
		nextPutAll: segname;
		nextPutInt64: addr;
		nextPutInt64: sectionSize;
		nextPutInt32: offset;
		nextPutInt32: align;
		nextPutInt32: reloff;
		nextPutInt32: nreloc;
		nextPutInt32: flags;
		nextPutInt32: 0;
		nextPutInt32: 0;
		nextPutInt32: 0.

]
