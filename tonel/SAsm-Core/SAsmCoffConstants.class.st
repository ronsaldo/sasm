Class {
	#name : #SAsmCoffConstants,
	#superclass : #SharedPool,
	#classVars : [
		'IMAGE_FILE_16BIT_MACHINE',
		'IMAGE_FILE_32BIT_MACHINE',
		'IMAGE_FILE_AGGRESSIVE_WS_TRIM',
		'IMAGE_FILE_BYTES_REVERSED_HI',
		'IMAGE_FILE_BYTES_REVERSED_LO',
		'IMAGE_FILE_DEBUG_STRIPPED',
		'IMAGE_FILE_DLL',
		'IMAGE_FILE_EXECUTABLE_IMAGE',
		'IMAGE_FILE_LARGE_ADDRESS_AWARE',
		'IMAGE_FILE_LINE_NUMS_STRIPPED',
		'IMAGE_FILE_LOCAL_SYMS_STRIPPED',
		'IMAGE_FILE_MACHINE_ALPHA',
		'IMAGE_FILE_MACHINE_ALPHA64',
		'IMAGE_FILE_MACHINE_AMD64',
		'IMAGE_FILE_MACHINE_ARM',
		'IMAGE_FILE_MACHINE_I386',
		'IMAGE_FILE_MACHINE_IA64',
		'IMAGE_FILE_MACHINE_M68K',
		'IMAGE_FILE_MACHINE_MIPS16',
		'IMAGE_FILE_MACHINE_MIPSFPU16',
		'IMAGE_FILE_MACHINE_POWERPC',
		'IMAGE_FILE_MACHINE_R10000',
		'IMAGE_FILE_MACHINE_R3000',
		'IMAGE_FILE_MACHINE_R4000',
		'IMAGE_FILE_MACHINE_SH3',
		'IMAGE_FILE_MACHINE_SH4',
		'IMAGE_FILE_MACHINE_THUMB',
		'IMAGE_FILE_MACHINE_UNKNOWN',
		'IMAGE_FILE_RELOCS_STRIPPED',
		'IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP',
		'IMAGE_FILE_SYSTEM',
		'IMAGE_FILE_UP_SYSTEM_ONLY',
		'IMAGE_REL_AMD64_ABSOLUTE',
		'IMAGE_REL_AMD64_ADDR32',
		'IMAGE_REL_AMD64_ADDR32NB',
		'IMAGE_REL_AMD64_ADDR64',
		'IMAGE_REL_AMD64_PAIR',
		'IMAGE_REL_AMD64_REL32',
		'IMAGE_REL_AMD64_REL32_1',
		'IMAGE_REL_AMD64_REL32_2',
		'IMAGE_REL_AMD64_REL32_3',
		'IMAGE_REL_AMD64_REL32_4',
		'IMAGE_REL_AMD64_REL32_5',
		'IMAGE_REL_AMD64_SECREL',
		'IMAGE_REL_AMD64_SECREL7',
		'IMAGE_REL_AMD64_SECTION',
		'IMAGE_REL_AMD64_SREL32',
		'IMAGE_REL_AMD64_SSPAN32',
		'IMAGE_REL_AMD64_TOKEN',
		'IMAGE_REL_I386_ABSOLUTE',
		'IMAGE_REL_I386_DIR16',
		'IMAGE_REL_I386_DIR32',
		'IMAGE_REL_I386_DIR32NB',
		'IMAGE_REL_I386_REL16',
		'IMAGE_REL_I386_REL32',
		'IMAGE_REL_I386_SECREL',
		'IMAGE_REL_I386_SECTION',
		'IMAGE_REL_I386_SEG12',
		'IMAGE_SCN_ALIGN_1024BYTES',
		'IMAGE_SCN_ALIGN_128BYTES',
		'IMAGE_SCN_ALIGN_16BYTES',
		'IMAGE_SCN_ALIGN_1BYTES',
		'IMAGE_SCN_ALIGN_2048BYTES',
		'IMAGE_SCN_ALIGN_256BYTES',
		'IMAGE_SCN_ALIGN_2BYTES',
		'IMAGE_SCN_ALIGN_32BYTES',
		'IMAGE_SCN_ALIGN_4096BYTES',
		'IMAGE_SCN_ALIGN_4BYTES',
		'IMAGE_SCN_ALIGN_512BYTES',
		'IMAGE_SCN_ALIGN_64BYTES',
		'IMAGE_SCN_ALIGN_8192BYTES',
		'IMAGE_SCN_ALIGN_8BYTES',
		'IMAGE_SCN_CNT_CODE',
		'IMAGE_SCN_CNT_INITIALIZED_DATA',
		'IMAGE_SCN_CNT_UNINITIALIZED_DATA',
		'IMAGE_SCN_LNK_COMDAT',
		'IMAGE_SCN_LNK_INFO',
		'IMAGE_SCN_LNK_NRELOC_OVFL',
		'IMAGE_SCN_LNK_OTHER',
		'IMAGE_SCN_LNK_REMOVE',
		'IMAGE_SCN_MEM_16BIT',
		'IMAGE_SCN_MEM_DISCARDABLE',
		'IMAGE_SCN_MEM_EXECUTE',
		'IMAGE_SCN_MEM_FARDATA',
		'IMAGE_SCN_MEM_LOCKED',
		'IMAGE_SCN_MEM_NOT_CACHED',
		'IMAGE_SCN_MEM_NOT_PAGED',
		'IMAGE_SCN_MEM_PRELOAD',
		'IMAGE_SCN_MEM_PURGEABLE',
		'IMAGE_SCN_MEM_READ',
		'IMAGE_SCN_MEM_SHARED',
		'IMAGE_SCN_MEM_WRITE',
		'IMAGE_SCN_TYPE_COPY',
		'IMAGE_SCN_TYPE_DSECT',
		'IMAGE_SCN_TYPE_GROUP',
		'IMAGE_SCN_TYPE_NOLOAD',
		'IMAGE_SCN_TYPE_NO_PAD',
		'IMAGE_SCN_TYPE_OVER',
		'IMAGE_SCN_TYPE_REG',
		'IMAGE_SYM_CLASS_ARGUMENT',
		'IMAGE_SYM_CLASS_AUTOMATIC',
		'IMAGE_SYM_CLASS_BIT_FIELD',
		'IMAGE_SYM_CLASS_BLOCK',
		'IMAGE_SYM_CLASS_END_OF_FUNCTION',
		'IMAGE_SYM_CLASS_END_OF_STRUCT',
		'IMAGE_SYM_CLASS_ENUM_TAG',
		'IMAGE_SYM_CLASS_EXTERNAL',
		'IMAGE_SYM_CLASS_EXTERNAL_DEF',
		'IMAGE_SYM_CLASS_FILE',
		'IMAGE_SYM_CLASS_FUNCTION',
		'IMAGE_SYM_CLASS_LABELDEF',
		'IMAGE_SYM_CLASS_MEMBER_OF_ENUM',
		'IMAGE_SYM_CLASS_MEMBER_OF_STRUCT',
		'IMAGE_SYM_CLASS_MEMBER_OF_UNION',
		'IMAGE_SYM_CLASS_NULL',
		'IMAGE_SYM_CLASS_REGISTER',
		'IMAGE_SYM_CLASS_REGISTER_PARAM',
		'IMAGE_SYM_CLASS_SECTION',
		'IMAGE_SYM_CLASS_STATIC',
		'IMAGE_SYM_CLASS_STRUCT_TAG',
		'IMAGE_SYM_CLASS_TYPE_DEFINITION',
		'IMAGE_SYM_CLASS_UNDEFINED_LABEL',
		'IMAGE_SYM_CLASS_UNDEFINED_STATIC',
		'IMAGE_SYM_CLASS_UNION_TAG',
		'IMAGE_SYM_CLASS_WEAK_EXTERNAL',
		'IMAGE_SYM_DTYPE_ARRAY',
		'IMAGE_SYM_DTYPE_FUNCTION',
		'IMAGE_SYM_DTYPE_NULL',
		'IMAGE_SYM_DTYPE_POINTER',
		'IMAGE_SYM_TYPE_BYTE',
		'IMAGE_SYM_TYPE_CHAR',
		'IMAGE_SYM_TYPE_DOUBLE',
		'IMAGE_SYM_TYPE_DWORD',
		'IMAGE_SYM_TYPE_ENUM',
		'IMAGE_SYM_TYPE_FLOAT',
		'IMAGE_SYM_TYPE_INT',
		'IMAGE_SYM_TYPE_LONG',
		'IMAGE_SYM_TYPE_MOE',
		'IMAGE_SYM_TYPE_NULL',
		'IMAGE_SYM_TYPE_SHORT',
		'IMAGE_SYM_TYPE_STRUCT',
		'IMAGE_SYM_TYPE_UINT',
		'IMAGE_SYM_TYPE_UNION',
		'IMAGE_SYM_TYPE_VOID',
		'IMAGE_SYM_TYPE_WORD'
	],
	#category : #'SAsm-Core-Coff'
}

{ #category : #initialization }
SAsmCoffConstants class >> initialize [
	self
		initializeImageConstants;
		initializeI386Constants;
		initializeAMD64Constants;
		initializeSectionConstants;
		intializeSymbolConstants
]

{ #category : #initialization }
SAsmCoffConstants class >> initializeAMD64Constants [
	IMAGE_REL_AMD64_ABSOLUTE := 16r0000.
	IMAGE_REL_AMD64_ADDR64   := 16r0001.
	IMAGE_REL_AMD64_ADDR32   := 16r0002.
	IMAGE_REL_AMD64_ADDR32NB := 16r0003.
	IMAGE_REL_AMD64_REL32    := 16r0004.
	IMAGE_REL_AMD64_REL32_1  := 16r0005.
	IMAGE_REL_AMD64_REL32_2  := 16r0006.
	IMAGE_REL_AMD64_REL32_3  := 16r0007.
	IMAGE_REL_AMD64_REL32_4  := 16r0008.
	IMAGE_REL_AMD64_REL32_5  := 16r0009.
	IMAGE_REL_AMD64_SECTION  := 16r000a.
	IMAGE_REL_AMD64_SECREL   := 16r000b.
	IMAGE_REL_AMD64_SECREL7  := 16r000c.
	IMAGE_REL_AMD64_TOKEN    := 16r000d.
	IMAGE_REL_AMD64_SREL32   := 16r000e.
	IMAGE_REL_AMD64_PAIR     := 16r000f.
	IMAGE_REL_AMD64_SSPAN32  := 16r0010.
]

{ #category : #initialization }
SAsmCoffConstants class >> initializeI386Constants [
	IMAGE_REL_I386_ABSOLUTE := 16r0000. "This relocation is ignored."
	IMAGE_REL_I386_DIR16 := 16r0001. "Not supported."
	IMAGE_REL_I386_REL16 := 16r0002. "Not supported."
	IMAGE_REL_I386_DIR32 := 16r0006. "The target’s 32-bit virtual address."
	IMAGE_REL_I386_DIR32NB := 16r0007. "The target’s 32-bit relative virtual address."
	IMAGE_REL_I386_SEG12 := 16r0009. "Not supported."
	IMAGE_REL_I386_SECTION := 16r000A.
	IMAGE_REL_I386_SECREL := 16r000B.
	IMAGE_REL_I386_REL32 := 16r0014. "The 32-bit relative displacement to the target. This supports the x86 relative branch and call instructions."
]

{ #category : #initialization }
SAsmCoffConstants class >> initializeImageConstants [
	IMAGE_FILE_MACHINE_UNKNOWN := 0.
	IMAGE_FILE_MACHINE_ALPHA := 16r184.
	IMAGE_FILE_MACHINE_ARM := 16r1c0.
	IMAGE_FILE_MACHINE_ALPHA64 := 16r284. "Alpha AXPTM 64-bit."
	IMAGE_FILE_MACHINE_I386 := 16r14c. "Intel 386 or later, and compatible processors."
	IMAGE_FILE_MACHINE_AMD64 := 16r8664. "Intel 386 or later, and compatible processors."
	IMAGE_FILE_MACHINE_IA64 := 16r200. "Intel IA64TM"
	IMAGE_FILE_MACHINE_M68K := 16r268. "Motorola 68000 series."
	IMAGE_FILE_MACHINE_MIPS16 := 16r266. "IMAGE_FILE_MACHINE_MIPSFPU:= 16r366 MIPS with FPU"
	IMAGE_FILE_MACHINE_MIPSFPU16 := 16r466. "MIPS16 with FPU"
	IMAGE_FILE_MACHINE_POWERPC := 16r1f0. "Power PC, little endian."
	IMAGE_FILE_MACHINE_R3000 := 16r162.
	IMAGE_FILE_MACHINE_R4000:= 16r166.
	IMAGE_FILE_MACHINE_R10000:= 16r168.
	IMAGE_FILE_MACHINE_SH3:= 16r1a2. "Hitachi SH3"
	IMAGE_FILE_MACHINE_SH4:= 16r1a6. "Hitachi SH4"
	IMAGE_FILE_MACHINE_THUMB:= 16r1c2.
	
	IMAGE_FILE_RELOCS_STRIPPED := 16r0001. "Image only"
	IMAGE_FILE_EXECUTABLE_IMAGE := 16r0002. 
	IMAGE_FILE_LINE_NUMS_STRIPPED := 16r0004.
	IMAGE_FILE_LOCAL_SYMS_STRIPPED := 16r0008.
	IMAGE_FILE_AGGRESSIVE_WS_TRIM := 16r0010.
	IMAGE_FILE_LARGE_ADDRESS_AWARE := 16r0020. "App can handle > 2gb addresses."
	IMAGE_FILE_16BIT_MACHINE := 16r0040.
	IMAGE_FILE_BYTES_REVERSED_LO := 16r0080. "Little endian: LSB precedes MSB in memory."
	IMAGE_FILE_32BIT_MACHINE := 16r0100. "Machine based on 32-bit-word architecture."
	IMAGE_FILE_DEBUG_STRIPPED := 16r0200. "Debugging information removed from image file."
	IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP := 16r0400. "If image is on removable media, copy and run from swap file."
	IMAGE_FILE_SYSTEM := 16r1000. "The image file is a system file, not a user program."
	IMAGE_FILE_DLL := 16r2000. "The image file is a dynamic-link library (DLL)."
	IMAGE_FILE_UP_SYSTEM_ONLY := 16r4000. "File should be run only on a UP machine."
	IMAGE_FILE_BYTES_REVERSED_HI := 16r8000 "Big endian: MSB precedes LSB in memory."
]

{ #category : #initialization }
SAsmCoffConstants class >> initializeSectionConstants [
	IMAGE_SCN_TYPE_REG := 16r00000000. "Reserved for future use."
	IMAGE_SCN_TYPE_DSECT := 16r00000001. "Reserved for future use."
	IMAGE_SCN_TYPE_NOLOAD := 16r00000002. "Reserved for future use."
	IMAGE_SCN_TYPE_GROUP := 16r00000004. "Reserved for future use."
	IMAGE_SCN_TYPE_NO_PAD := 16r00000008.
	IMAGE_SCN_TYPE_COPY := 16r00000010. "Reserved for future use."
	IMAGE_SCN_CNT_CODE := 16r00000020. "Section contains executable code."
	IMAGE_SCN_CNT_INITIALIZED_DATA := 16r00000040. "Section contains initialized data."
	IMAGE_SCN_CNT_UNINITIALIZED_DATA := 16r00000080. "Section contains uninitialized data."
	IMAGE_SCN_LNK_OTHER := 16r00000100. "Reserved for future use."
	IMAGE_SCN_LNK_INFO := 16r00000200. "Section contains comments or other information. The .drectve section has this type. This is valid for object files only."
	IMAGE_SCN_TYPE_OVER := 16r00000400. "Reserved for future use."
	IMAGE_SCN_LNK_REMOVE := 16r00000800. "Section will not become part of the image. This is valid for object files only."
	IMAGE_SCN_LNK_COMDAT := 16r00001000. "Section contains COMDAT data. See Section 5.5.6, “COMDAT Sections,” for more information. This is valid for object files only."
	IMAGE_SCN_MEM_FARDATA := 16r00008000. "Reserved for future use."
	IMAGE_SCN_MEM_PURGEABLE := 16r00020000. "Reserved for future use."
	IMAGE_SCN_MEM_16BIT := 16r00020000. "Reserved for future use."
	IMAGE_SCN_MEM_LOCKED := 16r00040000. "Reserved for future use."
	IMAGE_SCN_MEM_PRELOAD := 16r00080000. "Reserved for future use."
	IMAGE_SCN_ALIGN_1BYTES := 16r00100000. "Align data on a 1-byte boundary. This is valid for object files only."
	IMAGE_SCN_ALIGN_2BYTES := 16r00200000. "Align data on a 2-byte boundary. This is valid for object files only."
	IMAGE_SCN_ALIGN_4BYTES := 16r00300000. "Align data on a 4-byte boundary. This is valid for object files only."
	IMAGE_SCN_ALIGN_8BYTES := 16r00400000. "Align data on a 8-byte boundary. This is valid for object files only."
	IMAGE_SCN_ALIGN_16BYTES := 16r00500000. "Align data on a 16-byte boundary. This is valid for object files only."
	IMAGE_SCN_ALIGN_32BYTES := 16r00600000. "Align data on a 32-byte boundary. This is valid for object files only."
	IMAGE_SCN_ALIGN_64BYTES := 16r00700000. "Align data on a 64-byte boundary. This is valid for object files only."
	IMAGE_SCN_ALIGN_128BYTES := 16r00800000. "Align data on a 128-byte boundary. This is valid for object files only."
	IMAGE_SCN_ALIGN_256BYTES := 16r00900000. "Align data on a 256-byte boundary. This is valid for object files only."
	IMAGE_SCN_ALIGN_512BYTES := 16r00A00000. "Align data on a 512-byte boundary. This is valid for object files only."
	IMAGE_SCN_ALIGN_1024BYTES := 16r00B00000. "Align data on a 1024-byte boundary. This is valid for object files only."
	IMAGE_SCN_ALIGN_2048BYTES := 16r00C00000. "Align data on a 2048-byte boundary. This is valid for object files only."
	IMAGE_SCN_ALIGN_4096BYTES := 16r00D00000. "Align data on a 4096-byte boundary.	This is valid for object files only."
	IMAGE_SCN_ALIGN_8192BYTES := 16r00E00000. "Align data on a 8192-byte boundary. This is valid for object files only."
	IMAGE_SCN_LNK_NRELOC_OVFL := 16r01000000. "Section contains extended relocations."
	IMAGE_SCN_MEM_DISCARDABLE := 16r02000000. "Section can be discarded as needed."
	IMAGE_SCN_MEM_NOT_CACHED := 16r04000000. "Section cannot be cached."
	IMAGE_SCN_MEM_NOT_PAGED := 16r08000000. "Section is not pageable."
	IMAGE_SCN_MEM_SHARED := 16r10000000. "Section can be shared in memory."
	IMAGE_SCN_MEM_EXECUTE := 16r20000000. "Section can be executed as code."
	IMAGE_SCN_MEM_READ := 16r40000000. "Section can be read."
	IMAGE_SCN_MEM_WRITE := 16r80000000.

]

{ #category : #initialization }
SAsmCoffConstants class >> intializeSymbolConstants [
	IMAGE_SYM_TYPE_NULL := 0. "No type information or unknown base type. Microsoft tools use this setting."
	IMAGE_SYM_TYPE_VOID := 1. "No valid type; used with void pointers and functions."
	IMAGE_SYM_TYPE_CHAR := 2. "Character (signed byte)."
	IMAGE_SYM_TYPE_SHORT := 3. "Two-byte signed integer."
	IMAGE_SYM_TYPE_INT := 4. "Natural integer type (normally four bytes in Windows NT)."
	IMAGE_SYM_TYPE_LONG := 5. "Four-byte signed integer."
	IMAGE_SYM_TYPE_FLOAT := 6. "Four-byte floating-point number."
	IMAGE_SYM_TYPE_DOUBLE := 7. "Eight-byte floating-point number."
	IMAGE_SYM_TYPE_STRUCT := 8. "Structure."
	IMAGE_SYM_TYPE_UNION := 9. "Union."
	IMAGE_SYM_TYPE_ENUM := 10. "Enumerated type."
	IMAGE_SYM_TYPE_MOE := 11. "Member of enumeration (a specific value)."
	IMAGE_SYM_TYPE_BYTE := 12. "Byte; unsigned one-byte integer."
	IMAGE_SYM_TYPE_WORD := 13. "Word; unsigned two-byte integer."
	IMAGE_SYM_TYPE_UINT := 14. "Unsigned integer of natural size (normally, four bytes)."
	IMAGE_SYM_TYPE_DWORD := 15.
	
	IMAGE_SYM_DTYPE_NULL := 0.
	IMAGE_SYM_DTYPE_POINTER := 1.
	IMAGE_SYM_DTYPE_FUNCTION := 2.
	IMAGE_SYM_DTYPE_ARRAY := 3.
	
	IMAGE_SYM_CLASS_END_OF_FUNCTION := -1.
	IMAGE_SYM_CLASS_NULL := 0.
	IMAGE_SYM_CLASS_AUTOMATIC := 1.
	IMAGE_SYM_CLASS_EXTERNAL := 2.
	IMAGE_SYM_CLASS_STATIC := 3.
	IMAGE_SYM_CLASS_REGISTER := 4.
	IMAGE_SYM_CLASS_EXTERNAL_DEF := 5.
	IMAGE_SYM_CLASS_LABELDEF := 6.
	IMAGE_SYM_CLASS_UNDEFINED_LABEL := 7.
	IMAGE_SYM_CLASS_MEMBER_OF_STRUCT := 8.
	IMAGE_SYM_CLASS_ARGUMENT := 9.
	IMAGE_SYM_CLASS_STRUCT_TAG := 10.
	IMAGE_SYM_CLASS_MEMBER_OF_UNION := 11.
	IMAGE_SYM_CLASS_UNION_TAG := 12.
	IMAGE_SYM_CLASS_TYPE_DEFINITION := 13.
	IMAGE_SYM_CLASS_UNDEFINED_STATIC := 14.
	IMAGE_SYM_CLASS_ENUM_TAG := 15.
	IMAGE_SYM_CLASS_MEMBER_OF_ENUM := 16.
	IMAGE_SYM_CLASS_REGISTER_PARAM := 17.
	IMAGE_SYM_CLASS_BIT_FIELD := 18.
	IMAGE_SYM_CLASS_BLOCK := 100.
	IMAGE_SYM_CLASS_FUNCTION := 101.
	IMAGE_SYM_CLASS_END_OF_STRUCT := 102.
	IMAGE_SYM_CLASS_FILE := 103.
	IMAGE_SYM_CLASS_SECTION := 104.
	IMAGE_SYM_CLASS_WEAK_EXTERNAL := 105
]
