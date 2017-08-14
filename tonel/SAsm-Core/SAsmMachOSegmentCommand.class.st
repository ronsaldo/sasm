Class {
	#name : #SAsmMachOSegmentCommand,
	#superclass : #SAsmMachOLoadCommandHeader,
	#instVars : [
		'segname',
		'vmaddr',
		'vmsize',
		'fileoff',
		'filesize',
		'maxprot',
		'initprot',
		'nsects',
		'flags',
		'sections'
	],
	#category : #'SAsm-Core-MachO'
}

{ #category : #adding }
SAsmMachOSegmentCommand >> addSection: aSection [
	sections add: aSection
]

{ #category : #'as yet unclassified' }
SAsmMachOSegmentCommand >> computeSectionOffsets [
	| sectionOffset |
	sectionOffset := 0.
	sections do: [ :sec |
		sec sectionOffset: sectionOffset.
		sectionOffset := sectionOffset + sec content size.
	]
]

{ #category : #'memory protections' }
SAsmMachOSegmentCommand >> executable [
	initprot := initprot | VM_PROT_EXECUTE.
	maxprot := maxprot | VM_PROT_EXECUTE.
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> fileoff [
	^ fileoff
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> fileoff: anObject [
	fileoff := anObject
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> filesize [
	^ filesize
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> filesize: anObject [
	filesize := anObject
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> flags [
	^ flags
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> flags: anObject [
	flags := anObject
]

{ #category : #'as yet unclassified' }
SAsmMachOSegmentCommand >> headerSize [
	^ 56
]

{ #category : #initialization }
SAsmMachOSegmentCommand >> initialize [
	super initialize.
	cmd := LC_SEGMENT.
	segname := ByteArray new: 16.
	sections := OrderedCollection new.
	
	vmaddr := 0.
	vmsize := 0.
	fileoff := 0.
	filesize := 0.
	maxprot := 0.
	initprot := 0.
	nsects := 0.
	flags := 0.
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> initprot [
	^ initprot
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> initprot: anObject [
	initprot := anObject
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> maxprot [
	^ maxprot
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> maxprot: anObject [
	maxprot := anObject
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> nsects [
	^ nsects
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> nsects: anObject [
	nsects := anObject
]

{ #category : #writing }
SAsmMachOSegmentCommand >> prepareForWritingToFile [
	| minOffset maxOffset |
	super prepareForWritingToFile.
	nsects := sections size.
	sections ifEmpty: [ ^ self ].

	minOffset := Float infinity.
	maxOffset := Float negativeInfinity.
	sections do: [ :section |
		section prepareForWritingToFile.
		minOffset := minOffset min: section offset.
		maxOffset := minOffset max: section offset + section sectionSize.
	].

	fileoff := minOffset.
	filesize := maxOffset - minOffset.
]

{ #category : #'memory protections' }
SAsmMachOSegmentCommand >> readable [
	initprot := initprot | VM_PROT_READ.
	maxprot := maxprot | VM_PROT_READ.
]

{ #category : #initialization }
SAsmMachOSegmentCommand >> sectionsSize [
	| result |
	result := 0.
	sections do: [ :sect | result := result + sect size ].
	^ result
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> segname [
	^ segname
]

{ #category : #initialization }
SAsmMachOSegmentCommand >> size [
	^ self headerSize + self sectionsSize
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> vmaddr [
	^ vmaddr
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> vmaddr: anObject [
	vmaddr := anObject
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> vmsize [
	^ vmsize
]

{ #category : #accessing }
SAsmMachOSegmentCommand >> vmsize: anObject [
	vmsize := anObject
]

{ #category : #writing }
SAsmMachOSegmentCommand >> writeOn: aStream [
	aStream
		nextPutInt32: cmd;
		nextPutInt32: cmdsize;
		nextPutAll: segname;
		nextPutInt32: vmaddr;
		nextPutInt32: vmsize;
		nextPutInt32: fileoff;
		nextPutInt32: filesize;
		nextPutInt32: maxprot;
		nextPutInt32: initprot;
		nextPutInt32: nsects;
		nextPutInt32: flags.
	sections do: [ :sect | sect writeOn: aStream ].
]

{ #category : #'memory protections' }
SAsmMachOSegmentCommand >> writeable [
	initprot := initprot | VM_PROT_WRITE.
	maxprot := maxprot | VM_PROT_WRITE.
]
