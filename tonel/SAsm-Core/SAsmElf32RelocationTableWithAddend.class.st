Class {
	#name : #SAsmElf32RelocationTableWithAddend,
	#superclass : #SAsmElfRelocationTable,
	#category : #'SAsm-Core-Elf'
}

{ #category : #factory }
SAsmElf32RelocationTableWithAddend >> relocationEntryClass [
	^ SAsmElf32RelocationAddendEntry
]
