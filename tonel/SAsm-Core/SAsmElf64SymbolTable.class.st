Class {
	#name : #SAsmElf64SymbolTable,
	#superclass : #SLVMElf32SymbolTable,
	#category : #'SAsm-Core-Elf'
}

{ #category : #factory }
SAsmElf64SymbolTable >> symbolEntryClass [
	^ SLVMElf64SymbolTableEntry
]
