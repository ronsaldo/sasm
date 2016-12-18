Class {
	#name : #SAsmElf32RelocationTable,
	#superclass : #SAsmElfRelocationTable,
	#category : #'SAsm-Core-Elf'
}

{ #category : #factory }
SAsmElf32RelocationTable >> relocationEntryClass [
	^ SAsmElf32RelocationEntry
]
