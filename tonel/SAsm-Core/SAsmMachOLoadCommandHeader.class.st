Class {
	#name : #SAsmMachOLoadCommandHeader,
	#superclass : #SAsmBinaryFileComponent,
	#instVars : [
		'cmd',
		'cmdsize'
	],
	#pools : [
		'SAsmMachConstants'
	],
	#category : #'SAsm-Core-MachO'
}

{ #category : #accessing }
SAsmMachOLoadCommandHeader >> cmd [
	^ cmd
]

{ #category : #accessing }
SAsmMachOLoadCommandHeader >> cmd: anObject [
	cmd := anObject
]

{ #category : #accessing }
SAsmMachOLoadCommandHeader >> cmdsize [
	^ cmdsize
]

{ #category : #accessing }
SAsmMachOLoadCommandHeader >> cmdsize: anObject [
	cmdsize := anObject
]

{ #category : #writing }
SAsmMachOLoadCommandHeader >> prepareForWritingToFile [
	self cmdsize: self size
]

{ #category : #accessing }
SAsmMachOLoadCommandHeader >> size [
	^ 8
]

{ #category : #writing }
SAsmMachOLoadCommandHeader >> writeOn: aStream [
	aStream
		nextPutInt32: cmd;
		nextPutInt32: cmdsize
]
