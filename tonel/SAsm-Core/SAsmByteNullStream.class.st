Class {
	#name : #SAsmByteNullStream,
	#superclass : #NullStream,
	#category : #'SAsm-Core-Binary'
}

{ #category : #accessing }
SAsmByteNullStream >> contents [
	^ ByteArray new
]
