Class {
	#name : #SAsmLirBinaryStream,
	#superclass : #ReadWriteStream,
	#category : #'SAsm-Core-Elf'
}

{ #category : #'as yet unclassified' }
SAsmLirBinaryStream >> nextPutInt16: value [
	self
		nextPut: (value bitAnd: 16rff);
		nextPut: ((value >> 8) bitAnd: 16rff)
]

{ #category : #'as yet unclassified' }
SAsmLirBinaryStream >> nextPutInt32: value [
	self
		nextPut: (value bitAnd: 16rff);
		nextPut: ((value >> 8) bitAnd: 16rff);
		nextPut: ((value >> 16) bitAnd: 16rff);
		nextPut: ((value >> 24) bitAnd: 16rff).
]

{ #category : #'as yet unclassified' }
SAsmLirBinaryStream >> nextPutInt64: value [
	self
		nextPut: (value bitAnd: 16rff);
		nextPut: ((value >> 8) bitAnd: 16rff);
		nextPut: ((value >> 16) bitAnd: 16rff);
		nextPut: ((value >> 24) bitAnd: 16rff);
		nextPut: ((value >> 32) bitAnd: 16rff);
		nextPut: ((value >> 40) bitAnd: 16rff);
		nextPut: ((value >> 48) bitAnd: 16rff);
		nextPut: ((value >> 56) bitAnd: 16rff).
]

{ #category : #'as yet unclassified' }
SAsmLirBinaryStream >> nextPutInt8: value [
	self nextPut: (value bitAnd: 16rff)
]
