Class {
	#name : #SAsmDWDebugInfoEntry,
	#superclass : #SAsmDWObject,
	#instVars : [
		'tag',
		'firstAttribute',
		'lastAttribute',
		'firstChild',
		'lastChild',
		'nextSibling'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #'as yet unclassified' }
SAsmDWDebugInfoEntry >> abbreviationEquals: other [
	| myPosition otherPosition |
	(tag ~= other tag or: [ self hasChildren ~= other hasChildren ]) ifTrue: [ ^ false ].
	
	myPosition := self firstAttribute.
	otherPosition := other firstAttribute.
	[ myPosition isNotNil and: [ otherPosition isNotNil ] ] whileTrue: [
		(myPosition abbreviationEquals: otherPosition) ifFalse: [ ^ false ].
		myPosition := myPosition next.
		otherPosition := otherPosition next
	].

	^ myPosition isNil and: otherPosition isNil.
]

{ #category : #'as yet unclassified' }
SAsmDWDebugInfoEntry >> abbreviationHash [
	| hash |
	hash := tag hash bitXor: self hasChildren hash.
	self attributesDo: [ :attr | hash := hash bitXor: attr abbreviationHash].
	^ hash
]

{ #category : #adding }
SAsmDWDebugInfoEntry >> addAttribute: anAttribute [
	self assert: anAttribute next isNil.
	
	lastAttribute ifNil: [ 
		firstAttribute := lastAttribute := anAttribute
	] ifNotNil: [
		self assert: lastAttribute next isNil.
		lastAttribute next: anAttribute.
		lastAttribute := anAttribute
	].
	^ anAttribute
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> addAttribute: attributeName addr: attributeValue [
	^ self addAttribute: (SAsmDWDebugInfoEntryAddrAttribute name: attributeName value: attributeValue asSAsmInstructionOperand)
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> addAttribute: attributeName data4: attributeValue [
	^ self addAttribute: (SAsmDWDebugInfoEntryData4Attribute name: attributeName value: attributeValue asSAsmConstantExpression)
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> addAttribute: attributeName data8: attributeValue [
	^ self addAttribute: (SAsmDWDebugInfoEntryData8Attribute name: attributeName value: attributeValue asSAsmConstantExpression)
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> addAttribute: attributeName dieReference: attributeValue [
	^ self addAttribute: (SAsmDWDebugInfoEntryDIEReferenceAttribute name: attributeName value: attributeValue)
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> addAttribute: attributeName sleb128: attributeValue [
	^ self addAttribute: (SAsmDWDebugInfoEntrySLEB128Attribute name: attributeName value: attributeValue)
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> addAttribute: attributeName string: attributeValue [
	^ self addAttribute: (SAsmDWDebugInfoEntryStringAttribute name: attributeName value: attributeValue)
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> addAttribute: attributeName uleb128: attributeValue [
	^ self addAttribute: (SAsmDWDebugInfoEntryULEB128Attribute name: attributeName value: attributeValue asSAsmConstantExpression)
]

{ #category : #adding }
SAsmDWDebugInfoEntry >> addChild: aChild [
	self assert: aChild nextSibling isNil.
	
	lastChild ifNil: [ 
		firstChild := lastChild := aChild
	] ifNotNil: [
		self assert: lastChild nextSibling isNil.
		lastChild nextSibling: aChild.
		lastChild := aChild
	].

	^ aChild
]

{ #category : #enumerating }
SAsmDWDebugInfoEntry >> allChildrenDo: aBlock [
	self childrenDo: [ :child |
		aBlock value: child.
		child allChildrenDo: aBlock
	]
]

{ #category : #accessing }
SAsmDWDebugInfoEntry >> attributeAt: attributeName ifPresent: aBlock [
	self attributesDo: [ :attr | attr name = attributeName ifTrue: [ ^ aBlock value: attr ] ]
]

{ #category : #accessing }
SAsmDWDebugInfoEntry >> attributes [
	^ Array streamContents: [ :out |
		self attributesDo: [ :child | out nextPut: child ]
	]
]

{ #category : #accessing }
SAsmDWDebugInfoEntry >> attributesDo: aBlock [
	| position |
	position := firstAttribute.
	[ position ] whileNotNil: [
		aBlock value: position.
		position := position next
	]
]

{ #category : #building }
SAsmDWDebugInfoEntry >> build: aBlock [
	aBlock value: self builder
]

{ #category : #building }
SAsmDWDebugInfoEntry >> builder [
	^ SAsmDWBuilder new currentNode: self; yourself
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> byteSize: aSize [
	^ self addAttribute: DW_AT_byte_size uleb128: aSize
]

{ #category : #accessing }
SAsmDWDebugInfoEntry >> children [
	^ Array streamContents: [ :out |
		self childrenDo: [ :child | out nextPut: child ]
	]
]

{ #category : #accessing }
SAsmDWDebugInfoEntry >> childrenDo: aBlock [
	| position |
	position := firstChild.
	[ position ] whileNotNil: [
		aBlock value: position.
		position := position nextSibling
	]
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> dataMemberLocation: anOffset [
	^ self addAttribute: DW_AT_data_member_location uleb128: anOffset
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> declaration: aBoolean [
	self addAttribute: DW_AT_declaration uleb128: aBoolean asBit
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> encoding: anEncoding [
	^ self addAttribute: DW_AT_encoding uleb128: anEncoding
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> encodingAddress [
	self encoding: DW_ATE_address
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> encodingBoolean [
	self encoding: DW_ATE_boolean
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> encodingFloat [
	self encoding: DW_ATE_float
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> encodingSigned [
	self encoding: DW_ATE_signed
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> encodingSignedChar [
	self encoding: DW_ATE_signed_char
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> encodingUnsigned [
	self encoding: DW_ATE_unsigned
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> encodingUnsignedChar [
	self encoding: DW_ATE_unsigned_char
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> external: aBoolean [
	self addAttribute: DW_AT_external uleb128: aBoolean asBit
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> findAttribute: attributeName [
	| position |
	position := firstAttribute.
	[ position ] whileNotNil: [
		position name = attributeName ifTrue: [ ^ position ].
		position := position next
	].

	^ nil
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> findOrAddAttribute: attributeName class: attributeClass [
	(self findAttribute: attributeName) ifNotNil: [ :result | ^ result ].
	^ self addAttribute: (attributeClass new name: attributeName)
]

{ #category : #accessing }
SAsmDWDebugInfoEntry >> firstAttribute [
	^ firstAttribute
]

{ #category : #accessing }
SAsmDWDebugInfoEntry >> firstChild [
	^ firstChild
]

{ #category : #'gt-inspector-extension' }
SAsmDWDebugInfoEntry >> gtInspectorAttributesIn: composite [
	<gtInspectorPresentationOrder: 1> 
	^ composite fastTable
		title: 'Attributes';
		display: [ self attributes ];
		beMultiple;
		enableElementIndex;
		wantsAutomaticRefresh: true;
		column: 'Name' evaluated: [ :value | value name printString ] width: 300;
		column: 'Vaue' evaluated: [ :value | GTObjectPrinter asTruncatedTextFrom: value value]
]

{ #category : #'gt-inspector-extension' }
SAsmDWDebugInfoEntry >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 0> 
	^ composite tree 
		title: 'Tree';
		display: [ :root | { self } ];
		children: [ :each | each children ];
		format: [ :node | node tag name asString ];
		send: #value
]

{ #category : #testing }
SAsmDWDebugInfoEntry >> hasChildren [
	^ firstChild isNotNil
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> highPC: value [
	^ self addAttribute: DW_AT_high_pc addr: value
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> highPCOffset: value [
	^ self addAttribute: DW_AT_high_pc data4: value
]

{ #category : #initialization }
SAsmDWDebugInfoEntry >> initialize [
	super initialize.
]

{ #category : #accessing }
SAsmDWDebugInfoEntry >> lastAttribute [
	^ lastAttribute
]

{ #category : #accessing }
SAsmDWDebugInfoEntry >> lastChild [
	^ lastChild
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> linkageName: aLinkageName [
	^ self addAttribute: DW_AT_linkage_name string: aLinkageName
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> location [
	^ self addAttribute: (SAsmDWDebugInfoEntryExpressionLocation new name: DW_AT_location)
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> lowPC: value [
	^ self addAttribute: DW_AT_low_pc addr: value
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> name: aName [
	^ self addAttribute: DW_AT_name string: aName
]

{ #category : #accessing }
SAsmDWDebugInfoEntry >> nextSibling [
	^ nextSibling
]

{ #category : #accessing }
SAsmDWDebugInfoEntry >> nextSibling: anObject [
	nextSibling := anObject
]

{ #category : #printing }
SAsmDWDebugInfoEntry >> printOn: aStream [
	tag printOn: aStream.
	self attributeAt: DW_AT_name ifPresent: [ :name |
		aStream nextPutAll: ': '; print: name value
	]
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> prototyped: aBoolean [
	self addAttribute: DW_AT_prototyped uleb128: aBoolean asBit
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> setAttribute: attributeName addr: attributeValue [
	^ (self findOrAddAttribute: attributeName class: SAsmDWDebugInfoEntryAddrAttribute)
		value: attributeValue asSAsmInstructionOperand;
		yourself
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> setAttribute: attributeName symbol: attributeValue [
	^ (self findOrAddAttribute: attributeName class: SAsmDWDebugInfoEntrySymbolAttribute)
		value: attributeValue asSAsmInstructionOperand;
		yourself
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> stmtList: address [
	^ self setAttribute: DW_AT_stmt_list symbol: address
]

{ #category : #accessing }
SAsmDWDebugInfoEntry >> tag [
	^ tag
]

{ #category : #accessing }
SAsmDWDebugInfoEntry >> tag: anObject [
	tag := anObject
]

{ #category : #'attributes setters' }
SAsmDWDebugInfoEntry >> type: aType [
	^ self addAttribute: DW_AT_type dieReference: aType
]

{ #category : #enumerating }
SAsmDWDebugInfoEntry >> withAllChildrenDo: aBlock [
	aBlock value: self.
	self allChildrenDo: aBlock
]

{ #category : #writing }
SAsmDWDebugInfoEntry >> writeAbbreviationWith: writer to: streamBuilder [
	streamBuilder uleb128: tag;
		constI8: (self hasChildren ifTrue: [ DW_CHILDREN_yes ] ifFalse: [DW_CHILDREN_no]).
	self attributesDo: [ :attr | attr writeAbbreviationWith: writer to: streamBuilder ].
	streamBuilder constI8: 0; constI8: 0
]
