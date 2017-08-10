Class {
	#name : #SAsmMachO64Builder,
	#superclass : #SAsmMachOBuilder,
	#category : #'SAsm-Core-MachO'
}

{ #category : #initialization }
SAsmMachO64Builder >> headerClass [
	^ SAsmMachOHeader64
]

{ #category : #accessing }
SAsmMachO64Builder >> headerMagic [
	^ MH_MAGIC_64
]

{ #category : #accessing }
SAsmMachO64Builder >> sectionClass [
	^ SAsmMachOSection64
]

{ #category : #'as yet unclassified' }
SAsmMachO64Builder >> segmentClass [
	^ SAsmMachOSegmentCommand64
]

{ #category : #'format classes' }
SAsmMachO64Builder >> symbolTableEntryClass [
	^ SAsmMachNList64
]
