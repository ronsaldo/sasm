Class {
	#name : #SAsmDWDebugInfoEntryStringAttribute,
	#superclass : #SAsmDWDebugInfoEntryAttribute,
	#category : #'SAsm-DWARF'
}

{ #category : #'as yet unclassified' }
SAsmDWDebugInfoEntryStringAttribute >> prepareForWritingWith: writer [
	writer internString: value
]

{ #category : #writing }
SAsmDWDebugInfoEntryStringAttribute >> writeAbbreviationFormWith: writer to: streamBuilder [
	streamBuilder uleb128: DW_FORM_strp
]

{ #category : #writing }
SAsmDWDebugInfoEntryStringAttribute >> writeAttributeWith: writer to: streamBuilder [
	writer writeString: value
]
