Class {
	#name : #SAsmDWDebugInfoEntryData8Attribute,
	#superclass : #SAsmDWDebugInfoEntryAttribute,
	#category : #'SAsm-DWARF'
}

{ #category : #writing }
SAsmDWDebugInfoEntryData8Attribute >> writeAbbreviationFormWith: writer to: streamBuilder [
	streamBuilder uleb128: DW_FORM_data8
]

{ #category : #writing }
SAsmDWDebugInfoEntryData8Attribute >> writeAttributeWith: writer to: streamBuilder [
	streamBuilder constI64: (value copyWithStreamBuilder: streamBuilder)
]
