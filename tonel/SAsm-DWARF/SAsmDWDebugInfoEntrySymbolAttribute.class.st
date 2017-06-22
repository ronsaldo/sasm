Class {
	#name : #SAsmDWDebugInfoEntrySymbolAttribute,
	#superclass : #SAsmDWDebugInfoEntryAttribute,
	#category : #'SAsm-DWARF'
}

{ #category : #writing }
SAsmDWDebugInfoEntrySymbolAttribute >> writeAbbreviationFormWith: writer to: streamBuilder [
	streamBuilder uleb128: DW_FORM_addr
]

{ #category : #writing }
SAsmDWDebugInfoEntrySymbolAttribute >> writeAttributeWith: writer to: streamBuilder [
	streamBuilder const: value size: writer pointerSize
]
