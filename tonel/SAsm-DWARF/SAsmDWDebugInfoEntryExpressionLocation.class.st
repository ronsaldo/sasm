Class {
	#name : #SAsmDWDebugInfoEntryExpressionLocation,
	#superclass : #SAsmDWDebugInfoEntryAttribute,
	#category : #'SAsm-DWARF'
}

{ #category : #building }
SAsmDWDebugInfoEntryExpressionLocation >> build: aBlock [
	value := SAsmDWExpressionBuilder build: aBlock
]

{ #category : #writing }
SAsmDWDebugInfoEntryExpressionLocation >> writeAbbreviationFormWith: writer to: streamBuilder [
	streamBuilder uleb128: DW_FORM_exprloc
]

{ #category : #writing }
SAsmDWDebugInfoEntryExpressionLocation >> writeAttributeWith: writer to: streamBuilder [
	| size |
	size := 0.
	value do: [ :instruction |
		size := size + (instruction sizeWith: writer)
	].

	streamBuilder uleb128: size.
	value do: [ :instruction |
		instruction writeWith: writer to: streamBuilder
	].

]
