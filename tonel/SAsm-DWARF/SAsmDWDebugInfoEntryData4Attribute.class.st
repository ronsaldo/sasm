Class {
	#name : #SAsmDWDebugInfoEntryData4Attribute,
	#superclass : #SAsmDWDebugInfoEntryAttribute,
	#category : #'SAsm-DWARF'
}

{ #category : #writing }
SAsmDWDebugInfoEntryData4Attribute >> writeAbbreviationFormWith: writer to: streamBuilder [
	streamBuilder uleb128: DW_FORM_data4
]

{ #category : #writing }
SAsmDWDebugInfoEntryData4Attribute >> writeAttributeWith: writer to: streamBuilder [
	streamBuilder constI32: (value copyWithStreamBuilder: streamBuilder)
]
