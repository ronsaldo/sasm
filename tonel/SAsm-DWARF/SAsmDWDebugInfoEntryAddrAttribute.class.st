Class {
	#name : #SAsmDWDebugInfoEntryAddrAttribute,
	#superclass : #SAsmDWDebugInfoEntryAttribute,
	#category : #'SAsm-DWARF'
}

{ #category : #writing }
SAsmDWDebugInfoEntryAddrAttribute >> writeAbbreviationFormWith: writer to: streamBuilder [
	streamBuilder uleb128: DW_FORM_addr
]

{ #category : #writing }
SAsmDWDebugInfoEntryAddrAttribute >> writeAttributeWith: writer to: streamBuilder [
	streamBuilder const: (value copyWithStreamBuilder: streamBuilder) size: writer pointerSize
]
