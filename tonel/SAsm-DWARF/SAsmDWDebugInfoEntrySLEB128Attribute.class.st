Class {
	#name : #SAsmDWDebugInfoEntrySLEB128Attribute,
	#superclass : #SAsmDWDebugInfoEntryAttribute,
	#category : #'SAsm-DWARF'
}

{ #category : #writing }
SAsmDWDebugInfoEntrySLEB128Attribute >> writeAbbreviationFormWith: writer to: streamBuilder [
	streamBuilder uleb128: DW_FORM_sdata
]

{ #category : #writing }
SAsmDWDebugInfoEntrySLEB128Attribute >> writeAttributeWith: writer to: streamBuilder [
	streamBuilder sleb128: value
]
