Class {
	#name : #SAsmDWDebugInfoEntryULEB128Attribute,
	#superclass : #SAsmDWDebugInfoEntryAttribute,
	#category : #'SAsm-DWARF'
}

{ #category : #writing }
SAsmDWDebugInfoEntryULEB128Attribute >> writeAbbreviationFormWith: writer to: streamBuilder [
	streamBuilder uleb128: DW_FORM_udata
]

{ #category : #writing }
SAsmDWDebugInfoEntryULEB128Attribute >> writeAttributeWith: writer to: streamBuilder [
	streamBuilder uleb128: (value copyWithStreamBuilder: streamBuilder)
]
