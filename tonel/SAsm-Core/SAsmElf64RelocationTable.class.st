Class {
	#name : #SAsmElf64RelocationTable,
	#superclass : #SAsmElfRelocationTable,
	#category : #'SAsm-Core-Elf'
}

{ #category : #factory }
SAsmElf64RelocationTable >> relocationEntryClass [
	^ SAsmElf64RelocationEntry
]
