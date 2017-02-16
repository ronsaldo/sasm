Class {
	#name : #SAsmBinaryObjectSectionRelocation,
	#superclass : #Object,
	#instVars : [
		'section',
		'offset',
		'addend',
		'symbol',
		'type'
	],
	#classVars : [
		'AbsoluteOffset16',
		'AbsoluteOffset32',
		'AbsoluteOffset64',
		'AbsoluteOffset8',
		'RelativeSOffset16',
		'RelativeSOffset32',
		'RelativeSOffset64',
		'RelativeSOffset8'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #'as yet unclassified' }
SAsmBinaryObjectSectionRelocation class >> initialize [
	super initialize.
	
	AbsoluteOffset8 := #'absolute-offset8'.
	AbsoluteOffset16 := #'absolute-offset16'.
	AbsoluteOffset32 := #'absolute-offset32'.
	AbsoluteOffset64 := #'absolute-offset64'.
	
	RelativeSOffset8 := #'relative-soffset8'.
	RelativeSOffset16 := #'relative-soffset16'.
	RelativeSOffset32 := #'relative-soffset32'.
	RelativeSOffset64 := #'relative-soffset64'.
]

{ #category : #comparing }
SAsmBinaryObjectSectionRelocation >> = other [
	^ self class == other class and:
	[ type == other type and:
	[ offset = other offset and:
	[ addend = other addend and:
	[ symbol = other symbol ] ] ] ]
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> absoluteOffset16 [
	type := AbsoluteOffset16
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> absoluteOffset32 [
	type := AbsoluteOffset32
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> absoluteOffset64 [
	type := AbsoluteOffset64
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> absoluteOffset8 [
	type := AbsoluteOffset8
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> absoluteOffsetOfSize: offsetSize [
	offsetSize = 8 ifTrue: [ self absoluteOffset64 ].
	offsetSize = 4 ifTrue: [ self absoluteOffset32 ].
	offsetSize = 2 ifTrue: [ self absoluteOffset16 ].	
	offsetSize = 1 ifTrue: [ self absoluteOffset8 ].	
]

{ #category : #accessing }
SAsmBinaryObjectSectionRelocation >> addend [
	^ addend
]

{ #category : #accessing }
SAsmBinaryObjectSectionRelocation >> addend: anObject [
	addend := anObject
]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectSectionRelocation >> applyFullRelocationIn: targetSection [
	| data base |	
	data := targetSection data.
	base := section ifNotNil: [ section base ] ifNil: [ 0 ].
	
	(self isAbsoluteOffset64 or: [ self isRelativeSOffset64 ]) ifTrue: [ 
		data unsignedLongLongAt: offset + 1 put: (base + addend bitAnd: 16rFFFFFFFFFFFFFFFF)
	].

	(self isAbsoluteOffset32 or: [ self isRelativeSOffset32 ]) ifTrue: [
		data unsignedLongAt: offset + 1 put: (addend + (targetSection base - base) bitAnd: 16rFFFFFFFF)
	].

]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectSectionRelocation >> applyImplicitAddendIn: targetSection [
	| data |	
	data := targetSection data.
	(self isAbsoluteOffset64 or: [ self isRelativeSOffset64 ]) ifTrue: [ 
		data unsignedLongLongAt: offset + 1 put: (addend bitAnd: 16rFFFFFFFFFFFFFFFF)
	].

	(self isAbsoluteOffset32 or: [ self isRelativeSOffset32 ]) ifTrue: [
		data unsignedLongAt: offset + 1 put: (addend bitAnd: 16rFFFFFFFF)
	].

]

{ #category : #'as yet unclassified' }
SAsmBinaryObjectSectionRelocation >> clearImplicitAddendIn: targetSection [
	| data |	
	data := targetSection data.
	(self isAbsoluteOffset64 or: [ self isRelativeSOffset64 ]) ifTrue: [ 
		data unsignedLongLongAt: offset + 1 put: 0
	].

	(self isAbsoluteOffset32 or: [ self isRelativeSOffset32 ]) ifTrue: [
		data unsignedLongAt: offset + 1 put: 0
	].

]

{ #category : #initialization }
SAsmBinaryObjectSectionRelocation >> initialize [
	super initialize.
	type := AbsoluteOffset32.
	offset := 0.
	addend := 0.
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> isAbsoluteOffset16 [
	^ type == AbsoluteOffset16
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> isAbsoluteOffset32 [
	^ type == AbsoluteOffset32
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> isAbsoluteOffset64 [
	^ type == AbsoluteOffset64
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> isAbsoluteOffset8 [
	^ type == AbsoluteOffset8
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> isRelativeSOffset16 [
	^ type == RelativeSOffset16
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> isRelativeSOffset32 [
	^ type == RelativeSOffset32
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> isRelativeSOffset64 [
	^ type == RelativeSOffset64
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> isRelativeSOffset8 [
	^ type == RelativeSOffset8
]

{ #category : #accessing }
SAsmBinaryObjectSectionRelocation >> offset [
	^ offset
]

{ #category : #accessing }
SAsmBinaryObjectSectionRelocation >> offset: anObject [
	offset := anObject
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> relativeOffsetOfSize: offsetSize [
	offsetSize = 8 ifTrue: [ self relativeSOffset64 ].
	offsetSize = 4 ifTrue: [ self relativeSOffset32 ].
	offsetSize = 2 ifTrue: [ self relativeSOffset16 ].	
	offsetSize = 1 ifTrue: [ self relativeSOffset8 ].	

]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> relativeSOffset16 [
	type := RelativeSOffset16
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> relativeSOffset32 [
	type := RelativeSOffset32
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> relativeSOffset64 [
	type := RelativeSOffset64
]

{ #category : #testing }
SAsmBinaryObjectSectionRelocation >> relativeSOffset8 [
	type := RelativeSOffset8
]

{ #category : #accessing }
SAsmBinaryObjectSectionRelocation >> section [
	^ section
]

{ #category : #accessing }
SAsmBinaryObjectSectionRelocation >> section: anObject [
	section := anObject
]

{ #category : #accessing }
SAsmBinaryObjectSectionRelocation >> symbol [
	^ symbol
]

{ #category : #accessing }
SAsmBinaryObjectSectionRelocation >> symbol: anObject [
	symbol := anObject
]

{ #category : #accessing }
SAsmBinaryObjectSectionRelocation >> type [
	^ type
]

{ #category : #accessing }
SAsmBinaryObjectSectionRelocation >> type: anObject [
	type := anObject
]
