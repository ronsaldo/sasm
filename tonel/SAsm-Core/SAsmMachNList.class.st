Class {
	#name : #SAsmMachNList,
	#superclass : #Object,
	#instVars : [
		'n_strx',
		'n_type',
		'n_sect',
		'n_desc',
		'n_value'
	],
	#pools : [
		'SAsmMachConstants'
	],
	#category : #'SAsm-Core-MachO'
}

{ #category : #'as yet unclassified' }
SAsmMachNList class >> entrySize [
	^ 12
]

{ #category : #initialization }
SAsmMachNList >> initialize [
	super initialize.
	n_strx := 0.
	n_type := 0.
	n_sect := 0.
	n_desc := 0.
	n_value := 0.
]

{ #category : #accessing }
SAsmMachNList >> n_desc [
	^ n_desc
]

{ #category : #accessing }
SAsmMachNList >> n_desc: anObject [
	n_desc := anObject
]

{ #category : #accessing }
SAsmMachNList >> n_sect [
	^ n_sect
]

{ #category : #accessing }
SAsmMachNList >> n_sect: anObject [
	n_sect := anObject
]

{ #category : #accessing }
SAsmMachNList >> n_strx [
	^ n_strx
]

{ #category : #accessing }
SAsmMachNList >> n_strx: anObject [
	n_strx := anObject
]

{ #category : #accessing }
SAsmMachNList >> n_type [
	^ n_type
]

{ #category : #accessing }
SAsmMachNList >> n_type: anObject [
	n_type := anObject
]

{ #category : #accessing }
SAsmMachNList >> n_value [
	^ n_value
]

{ #category : #accessing }
SAsmMachNList >> n_value: anObject [
	n_value := anObject
]

{ #category : #accessing }
SAsmMachNList >> size [
	^ self class entrySize
]

{ #category : #writing }
SAsmMachNList >> writeOn: aStream [
	aStream
		nextPutInt32: n_strx;
		nextPutInt8: n_type;
		nextPutInt8: n_sect;
		nextPutInt16: n_desc;
		nextPutInt32: n_value
]
