"
I am a trait that provides accessor, setters and testing methods for visibility class.
"
Trait {
	#name : #TSAsmVisibility,
	#category : #'SAsm-Core-Generic'
}

{ #category : #testing }
TSAsmVisibility >> isDllExport [
	^ self visibility == #dllexport
]

{ #category : #testing }
TSAsmVisibility >> isDllImport [
	^ self visibility == #dllimport
]

{ #category : #testing }
TSAsmVisibility >> isExternal [
	^ self visibility == #external
]

{ #category : #testing }
TSAsmVisibility >> isPrivate [
	^ self visibility == #private
]

{ #category : #testing }
TSAsmVisibility >> isPublic [
	^ self visibility == #public
]

{ #category : #testing }
TSAsmVisibility >> isWeak [
	^ self visibility == #weak
]

{ #category : #visibility }
TSAsmVisibility >> makeDllExport [
	self visibility: #dllexport
]

{ #category : #visibility }
TSAsmVisibility >> makeDllImport [
	self visibility: #dllimport
]

{ #category : #visibility }
TSAsmVisibility >> makeExternal [
	self visibility: #external
]

{ #category : #visibility }
TSAsmVisibility >> makePrivate [
	self visibility: #private
]

{ #category : #visibility }
TSAsmVisibility >> makePublic [
	self visibility: #public
]

{ #category : #visibility }
TSAsmVisibility >> makeWeak [
	self visibility: #weak
]
