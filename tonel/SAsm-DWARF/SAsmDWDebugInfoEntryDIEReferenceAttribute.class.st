Class {
	#name : #SAsmDWDebugInfoEntryDIEReferenceAttribute,
	#superclass : #SAsmDWDebugInfoEntryAttribute,
	#category : #'SAsm-DWARF'
}

{ #category : #writing }
SAsmDWDebugInfoEntryDIEReferenceAttribute >> writeAbbreviationFormWith: writer to: streamBuilder [
	streamBuilder uleb128: DW_FORM_ref_addr
]

{ #category : #writing }
SAsmDWDebugInfoEntryDIEReferenceAttribute >> writeAttributeWith: writer to: streamBuilder [
	writer writeReferenceToDIE: value
]
