Class {
	#name : #SAsmElf64RelocationTableWithAddend,
	#superclass : #SAsmElfRelocationTable,
	#category : #'SAsm-Core-Elf'
}

{ #category : #factory }
SAsmElf64RelocationTableWithAddend >> relocationEntryClass [
	^ SAsmElf64RelocationAddendEntry
]
