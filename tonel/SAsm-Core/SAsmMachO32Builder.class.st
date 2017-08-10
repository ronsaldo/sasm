Class {
	#name : #SAsmMachO32Builder,
	#superclass : #SAsmMachOBuilder,
	#category : #'SAsm-Core-MachO'
}

{ #category : #initialization }
SAsmMachO32Builder >> headerClass [
	^ SAsmMachOHeader32
]

{ #category : #initialization }
SAsmMachO32Builder >> headerMagic [
	^ MH_MAGIC
]

{ #category : #initialization }
SAsmMachO32Builder >> sectionClass [
	^ SAsmMachOSection32
]

{ #category : #'as yet unclassified' }
SAsmMachO32Builder >> segmentClass [
	^ SAsmMachOSegmentCommand
]

{ #category : #'format classes' }
SAsmMachO32Builder >> symbolTableEntryClass [
	^ SAsmMachNList
]
