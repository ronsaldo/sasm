Class {
	#name : #SAsmElf64SymbolTable,
	#superclass : #SAsmElf32SymbolTable,
	#category : #'SAsm-Core-Elf'
}

{ #category : #factory }
SAsmElf64SymbolTable >> symbolEntryClass [
	^ SAsmElf64SymbolTableEntry
]
