Class {
	#name : #SAsmMachConstants,
	#superclass : #SharedPool,
	#classVars : [
		'CPUFAMILY_ARM_11',
		'CPUFAMILY_ARM_13',
		'CPUFAMILY_ARM_9',
		'CPUFAMILY_ARM_XSCALE',
		'CPUFAMILY_INTEL_6_13',
		'CPUFAMILY_INTEL_MEROM',
		'CPUFAMILY_INTEL_NEHALEM',
		'CPUFAMILY_INTEL_PENRYN',
		'CPUFAMILY_INTEL_WESTMERE',
		'CPUFAMILY_INTEL_YONAH',
		'CPUFAMILY_POWERPC_G3',
		'CPUFAMILY_POWERPC_G4',
		'CPUFAMILY_POWERPC_G5',
		'CPUFAMILY_UNKNOWN',
		'CPU_ARCH_ABI64',
		'CPU_ARCH_MASK',
		'CPU_STATE_IDLE',
		'CPU_STATE_MAX',
		'CPU_STATE_NICE',
		'CPU_STATE_SYSTEM',
		'CPU_STATE_USER',
		'CPU_SUBTYPE_386',
		'CPU_SUBTYPE_486',
		'CPU_SUBTYPE_486SX',
		'CPU_SUBTYPE_586',
		'CPU_SUBTYPE_ARM_ALL',
		'CPU_SUBTYPE_ARM_V4T',
		'CPU_SUBTYPE_ARM_V5TEJ',
		'CPU_SUBTYPE_ARM_V6',
		'CPU_SUBTYPE_ARM_V7',
		'CPU_SUBTYPE_ARM_XSCALE',
		'CPU_SUBTYPE_BIG_ENDIAN',
		'CPU_SUBTYPE_CELERON',
		'CPU_SUBTYPE_CELERON_MOBILE',
		'CPU_SUBTYPE_HPPA_7100',
		'CPU_SUBTYPE_HPPA_7100LC',
		'CPU_SUBTYPE_HPPA_ALL',
		'CPU_SUBTYPE_I386_ALL',
		'CPU_SUBTYPE_I860_860',
		'CPU_SUBTYPE_I860_ALL',
		'CPU_SUBTYPE_INTEL_FAMILY_MAX',
		'CPU_SUBTYPE_INTEL_MODEL_ALL',
		'CPU_SUBTYPE_ITANIUM',
		'CPU_SUBTYPE_ITANIUM_2',
		'CPU_SUBTYPE_LIB64',
		'CPU_SUBTYPE_LITTLE_ENDIAN',
		'CPU_SUBTYPE_MASK',
		'CPU_SUBTYPE_MC68030',
		'CPU_SUBTYPE_MC68030_ONLY',
		'CPU_SUBTYPE_MC68040',
		'CPU_SUBTYPE_MC680x0_ALL',
		'CPU_SUBTYPE_MC88000_ALL',
		'CPU_SUBTYPE_MC88100',
		'CPU_SUBTYPE_MC88110',
		'CPU_SUBTYPE_MC98000_ALL',
		'CPU_SUBTYPE_MC98601',
		'CPU_SUBTYPE_MIPS_ALL',
		'CPU_SUBTYPE_MIPS_R2000',
		'CPU_SUBTYPE_MIPS_R2000a',
		'CPU_SUBTYPE_MIPS_R2300',
		'CPU_SUBTYPE_MIPS_R2600',
		'CPU_SUBTYPE_MIPS_R2800',
		'CPU_SUBTYPE_MIPS_R3000',
		'CPU_SUBTYPE_MIPS_R3000a',
		'CPU_SUBTYPE_MULTIPLE',
		'CPU_SUBTYPE_PENT',
		'CPU_SUBTYPE_PENTII_M3',
		'CPU_SUBTYPE_PENTII_M5',
		'CPU_SUBTYPE_PENTIUM_3',
		'CPU_SUBTYPE_PENTIUM_3_M',
		'CPU_SUBTYPE_PENTIUM_3_XEON',
		'CPU_SUBTYPE_PENTIUM_4',
		'CPU_SUBTYPE_PENTIUM_4_M',
		'CPU_SUBTYPE_PENTIUM_M',
		'CPU_SUBTYPE_PENTPRO',
		'CPU_SUBTYPE_POWERPC_601',
		'CPU_SUBTYPE_POWERPC_602',
		'CPU_SUBTYPE_POWERPC_603',
		'CPU_SUBTYPE_POWERPC_603e',
		'CPU_SUBTYPE_POWERPC_603ev',
		'CPU_SUBTYPE_POWERPC_604',
		'CPU_SUBTYPE_POWERPC_604e',
		'CPU_SUBTYPE_POWERPC_620',
		'CPU_SUBTYPE_POWERPC_7400',
		'CPU_SUBTYPE_POWERPC_7450',
		'CPU_SUBTYPE_POWERPC_750',
		'CPU_SUBTYPE_POWERPC_970',
		'CPU_SUBTYPE_POWERPC_ALL',
		'CPU_SUBTYPE_SPARC_ALL',
		'CPU_SUBTYPE_UVAXI',
		'CPU_SUBTYPE_UVAXII',
		'CPU_SUBTYPE_UVAXIII',
		'CPU_SUBTYPE_VAX730',
		'CPU_SUBTYPE_VAX750',
		'CPU_SUBTYPE_VAX780',
		'CPU_SUBTYPE_VAX785',
		'CPU_SUBTYPE_VAX8200',
		'CPU_SUBTYPE_VAX8500',
		'CPU_SUBTYPE_VAX8600',
		'CPU_SUBTYPE_VAX8650',
		'CPU_SUBTYPE_VAX8800',
		'CPU_SUBTYPE_VAX_ALL',
		'CPU_SUBTYPE_X86_64_ALL',
		'CPU_SUBTYPE_X86_ALL',
		'CPU_SUBTYPE_X86_ARCH1',
		'CPU_SUBTYPE_XEON',
		'CPU_SUBTYPE_XEON_MP',
		'CPU_THREADTYPE_INTEL_HTT',
		'CPU_THREADTYPE_NONE',
		'CPU_TYPE_ANY',
		'CPU_TYPE_ARM',
		'CPU_TYPE_HPPA',
		'CPU_TYPE_I386',
		'CPU_TYPE_I860',
		'CPU_TYPE_MC680x0',
		'CPU_TYPE_MC88000',
		'CPU_TYPE_MC98000',
		'CPU_TYPE_POWERPC',
		'CPU_TYPE_POWERPC64',
		'CPU_TYPE_SPARC',
		'CPU_TYPE_VAX',
		'CPU_TYPE_X86',
		'CPU_TYPE_X86_64',
		'GENERIC_RELOC_LOCAL_SECTDIFF',
		'GENERIC_RELOC_PAIR',
		'GENERIC_RELOC_PB_LA_PTR',
		'GENERIC_RELOC_SECTDIFF',
		'GENERIC_RELOC_TLV',
		'GENERIC_RELOC_VANILLA',
		'LC_CODE_SIGNATURE',
		'LC_DATA_IN_CODE',
		'LC_DYLD_ENVIRONMENT',
		'LC_DYLD_INFO',
		'LC_DYLD_INFO_ONLY',
		'LC_DYLIB_CODE_SIGN_DRS',
		'LC_DYSYMTAB',
		'LC_ENCRYPTION_INFO',
		'LC_ENCRYPTION_INFO_64',
		'LC_FUNCTION_STARTS',
		'LC_FVMFILE',
		'LC_IDENT',
		'LC_IDFVMLIB',
		'LC_ID_DYLIB',
		'LC_ID_DYLINKER',
		'LC_LAZY_LOAD_DYLIB',
		'LC_LINKER_OPTIMIZATION_HINT',
		'LC_LINKER_OPTION',
		'LC_LOADFVMLIB',
		'LC_LOAD_DYLIB',
		'LC_LOAD_DYLINKER',
		'LC_LOAD_UPWARD_DYLIB',
		'LC_LOAD_WEAK_DYLIB',
		'LC_MAIN',
		'LC_PREBIND_CKSUM',
		'LC_PREBOUND_DYLIB',
		'LC_PREPAGE',
		'LC_REEXPORT_DYLIB',
		'LC_REQ_DYLD',
		'LC_ROUTINES',
		'LC_ROUTINES_64',
		'LC_RPATH',
		'LC_SEGMENT',
		'LC_SEGMENT_64',
		'LC_SEGMENT_SPLIT_INFO',
		'LC_SOURCE_VERSION',
		'LC_SUB_CLIENT',
		'LC_SUB_FRAMEWORK',
		'LC_SUB_LIBRARY',
		'LC_SUB_UMBRELLA',
		'LC_SYMSEG',
		'LC_SYMTAB',
		'LC_THREAD',
		'LC_TWOLEVEL_HINTS',
		'LC_UNIXTHREAD',
		'LC_UUID',
		'LC_VERSION_MIN_IPHONEOS',
		'LC_VERSION_MIN_MACOSX',
		'LC_VERSION_MIN_TVOS',
		'LC_VERSION_MIN_WATCHOS',
		'MAX_SEC',
		'MH_ALLMODSBOUND',
		'MH_ALLOW_STACK_EXECUTION',
		'MH_APP_EXTENSION_SAFE',
		'MH_BINDATLOAD',
		'MH_BINDS_TO_WEAK',
		'MH_BUNDLE',
		'MH_CANONICAL',
		'MH_CIGAM',
		'MH_CIGAM_64',
		'MH_CORE',
		'MH_DEAD_STRIPPABLE_DYLIB',
		'MH_DSYM',
		'MH_DYLDLINK',
		'MH_DYLIB',
		'MH_DYLIB_STUB',
		'MH_DYLINKER',
		'MH_EXECUTE',
		'MH_FORCE_FLAT',
		'MH_FVMLIB',
		'MH_HAS_TLV_DESCRIPTORS',
		'MH_INCRLINK',
		'MH_KEXT_BUNDLE',
		'MH_LAZY_INIT',
		'MH_MAGIC',
		'MH_MAGIC_64',
		'MH_NOFIXPREBINDING',
		'MH_NOMULTIDEFS',
		'MH_NOUNDEFS',
		'MH_NO_HEAP_EXECUTION',
		'MH_NO_REEXPORTED_DYLIBS',
		'MH_OBJECT',
		'MH_PIE',
		'MH_PREBINDABLE',
		'MH_PREBOUND',
		'MH_PRELOAD',
		'MH_ROOT_SAFE',
		'MH_SETUID_SAFE',
		'MH_SPLIT_SEGS',
		'MH_SUBSECTIONS_VIA_SYMBOLS',
		'MH_TWOLEVEL',
		'MH_WEAK_DEFINES',
		'NO_SECT',
		'N_ABS',
		'N_EXT',
		'N_INDR',
		'N_PBUD',
		'N_PEXT',
		'N_SECT',
		'N_STAB',
		'N_TYPE',
		'N_UNDF',
		'REFERENCE_FLAG_DEFINED',
		'REFERENCE_FLAG_PRIVATE_DEFINED',
		'REFERENCE_FLAG_PRIVATE_UNDEFINED_LAZY',
		'REFERENCE_FLAG_PRIVATE_UNDEFINED_NON_LAZY',
		'REFERENCE_FLAG_UNDEFINED_LAZY',
		'REFERENCE_FLAG_UNDEFINED_NON_LAZY',
		'REFERENCE_TYPE',
		'R_ABS',
		'SECTION_ATTRIBUTES',
		'SECTION_ATTRIBUTES_SYS',
		'SECTION_ATTRIBUTES_USR',
		'SECTION_TYPE',
		'SECT_BSS',
		'SECT_COMMON',
		'SECT_DATA',
		'SECT_FVMLIB_INIT0',
		'SECT_FVMLIB_INIT1',
		'SECT_ICON_HEADER',
		'SECT_ICON_TIFF',
		'SECT_OBJC_MODULES',
		'SECT_OBJC_REFS',
		'SECT_OBJC_STRINGS',
		'SECT_OBJC_SYMBOLS',
		'SECT_TEXT',
		'SEG_DATA',
		'SEG_ICON',
		'SEG_LINKEDIT',
		'SEG_OBJC',
		'SEG_PAGEZERO',
		'SEG_TEXT',
		'SG_FVMLIB',
		'SG_HIGHVM',
		'SG_NORELOC',
		'SG_PROTECTED_VERSION_1',
		'S_16BYTE_LITERALS',
		'S_4BYTE_LITERALS',
		'S_8BYTE_LITERALS',
		'S_ATTR_DEBUG',
		'S_ATTR_EXT_RELOC',
		'S_ATTR_LIVE_SUPPORT',
		'S_ATTR_LOC_RELOC',
		'S_ATTR_NO_DEAD_STRIP',
		'S_ATTR_NO_TOC',
		'S_ATTR_PURE_INSTRUCTIONS',
		'S_ATTR_SELF_MODIFYING_CODE',
		'S_ATTR_SOME_INSTRUCTIONS',
		'S_ATTR_STRIP_STATIC_SYMS',
		'S_COALESCED',
		'S_CSTRING_LITERALS',
		'S_DTRACE_DOF',
		'S_GB_ZEROFILL',
		'S_INTERPOSING',
		'S_LAZY_DYLIB_SYMBOL_POINTERS',
		'S_LAZY_SYMBOL_POINTERS',
		'S_LITERAL_POINTERS',
		'S_MOD_INIT_FUNC_POINTERS',
		'S_MOD_TERM_FUNC_POINTERS',
		'S_NON_LAZY_SYMBOL_POINTERS',
		'S_REGULAR',
		'S_SYMBOL_STUBS',
		'S_THREAD_LOCAL_INIT_FUNCTION_POINTERS',
		'S_THREAD_LOCAL_REGULAR',
		'S_THREAD_LOCAL_VARIABLES',
		'S_THREAD_LOCAL_VARIABLE_POINTERS',
		'S_THREAD_LOCAL_ZEROFILL',
		'S_ZEROFILL',
		'VM_PROT_EXECUTE',
		'VM_PROT_NONE',
		'VM_PROT_READ',
		'VM_PROT_WRITE',
		'X86_64_RELOC_BRANCH',
		'X86_64_RELOC_GOT',
		'X86_64_RELOC_GOT_LOAD',
		'X86_64_RELOC_SIGNED',
		'X86_64_RELOC_SIGNED_1',
		'X86_64_RELOC_SIGNED_2',
		'X86_64_RELOC_SIGNED_4',
		'X86_64_RELOC_SUBTRACTOR',
		'X86_64_RELOC_TLV',
		'X86_64_RELOC_UNSIGNED'
	],
	#category : #'SAsm-Core-MachO'
}

{ #category : #accessing }
SAsmMachConstants class >> CPU_SUBTYPE_I386_ALL [
	^ CPU_SUBTYPE_I386_ALL
]

{ #category : #accessing }
SAsmMachConstants class >> CPU_TYPE_X86 [
	^ CPU_TYPE_X86
]

{ #category : #accessing }
SAsmMachConstants class >> CPU_TYPE_X86_64 [
	^ CPU_TYPE_X86_64
]

{ #category : #accessing }
SAsmMachConstants class >> GENERIC_RELOC_LOCAL_SECTDIFF [
	^ GENERIC_RELOC_LOCAL_SECTDIFF
]

{ #category : #'as yet unclassified' }
SAsmMachConstants class >> GENERIC_RELOC_PAIR [
	^ GENERIC_RELOC_PAIR
]

{ #category : #accessing }
SAsmMachConstants class >> GENERIC_RELOC_SECTDIFF [
	^ GENERIC_RELOC_SECTDIFF
]

{ #category : #accessing }
SAsmMachConstants class >> GENERIC_RELOC_VANILLA [
	^ GENERIC_RELOC_VANILLA
]

{ #category : #accessing }
SAsmMachConstants class >> X86_64_RELOC_UNSIGNED [
	^ X86_64_RELOC_UNSIGNED
]

{ #category : #initialization }
SAsmMachConstants class >> cpu_subtype_intel: f with: m [
	^ (f) + ((m) << 4)
]

{ #category : #initialization }
SAsmMachConstants class >> initialize [
	self
		initializeHeaderConstants;
		initializeCommandConstants;
		initializeSegmentConstants;
		initializeSectionConstants;
		initializeMemoryConstants;
		initializeCpuConstants;
		initializeSymbolConstants;
		initializeRelocationsConstants
]

{ #category : #initialization }
SAsmMachConstants class >> initializeCommandConstants [
	LC_REQ_DYLD := 16r80000000.

" Constants for the cmd field of all load commands, the type "
	LC_SEGMENT	:= 16r1.	" segment of this file to be mapped "
	LC_SYMTAB	:= 16r2.	" link-edit stab symbol table info "
	LC_SYMSEG	:= 16r3.	" link-edit gdb symbol table info (obsolete) "
	LC_THREAD	:= 16r4.	" thread "
	LC_UNIXTHREAD	:= 16r5.	" unix thread (includes a stack) "
	LC_LOADFVMLIB	:= 16r6.	" load a specified fixed VM shared library "
	LC_IDFVMLIB	:= 16r7.	" fixed VM shared library identification "
	LC_IDENT	:= 16r8.	" object identification info (obsolete) "
	LC_FVMFILE	:= 16r9.	" fixed VM file inclusion (internal use) "
	LC_PREPAGE      := 16ra.     " prepage command (internal use) "
	LC_DYSYMTAB	:= 16rb.	" dynamic link-edit symbol table info "
	LC_LOAD_DYLIB	:= 16rc.	" load a dynamically linked shared library "
	LC_ID_DYLIB	:= 16rd.	" dynamically linked shared lib ident "
	LC_LOAD_DYLINKER := 16re.	" load a dynamic linker "
	LC_ID_DYLINKER	:= 16rf.	" dynamic linker identification "
	LC_PREBOUND_DYLIB := 16r10.	" modules prebound for a dynamically "
				"  linked shared library "
	LC_ROUTINES	:= 16r11.	" image routines "
	LC_SUB_FRAMEWORK := 16r12.	" sub framework "
	LC_SUB_UMBRELLA := 16r13.	" sub umbrella "
	LC_SUB_CLIENT	:= 16r14.	" sub client "
	LC_SUB_LIBRARY  := 16r15.	" sub library "
	LC_TWOLEVEL_HINTS := 16r16.	" two-level namespace lookup hints "
	LC_PREBIND_CKSUM  := 16r17.	" prebind checksum "

"
 * load a dynamically linked shared library that is allowed to be missing
 * (all symbols are weak imported).
 "
	LC_LOAD_WEAK_DYLIB := (16r18 | LC_REQ_DYLD).

	LC_SEGMENT_64	:= 16r19.	" 64-bit segment of this file to be
				   mapped "
	LC_ROUTINES_64	:= 16r1a.	" 64-bit image routines "
	LC_UUID		:= 16r1b.	" the uuid "
	LC_RPATH       := (16r1c | LC_REQ_DYLD).    " runpath additions "
	LC_CODE_SIGNATURE := 16r1d.	" local of code signature "
	LC_SEGMENT_SPLIT_INFO := 16r1e. " local of info to split segments "
	LC_REEXPORT_DYLIB := (16r1f | LC_REQ_DYLD). " load and re-export dylib "
	LC_LAZY_LOAD_DYLIB := 16r20.	" delay load of dylib until first use "
	LC_ENCRYPTION_INFO := 16r21.	" encrypted segment information "
	LC_DYLD_INFO 	:= 16r22.	" compressed dyld information "
	LC_DYLD_INFO_ONLY := (16r22|LC_REQ_DYLD).	" compressed dyld information only "
	LC_LOAD_UPWARD_DYLIB := (16r23 | LC_REQ_DYLD). " load upward dylib "
	LC_VERSION_MIN_MACOSX := 16r24.   " build for MacOSX min OS version "
	LC_VERSION_MIN_IPHONEOS := 16r25. " build for iPhoneOS min OS version "
	LC_FUNCTION_STARTS := 16r26. " compressed table of function start addresses "
	LC_DYLD_ENVIRONMENT := 16r27. " string for dyld to treat
				    like environment variable "
	LC_MAIN := (16r28|LC_REQ_DYLD). " replacement for LC_UNIXTHREAD "
	LC_DATA_IN_CODE := 16r29. " table of non-instructions in __text "
	LC_SOURCE_VERSION := 16r2A. " source version used to build binary "
	LC_DYLIB_CODE_SIGN_DRS := 16r2B. " Code signing DRs copied from linked dylibs "
	LC_ENCRYPTION_INFO_64 := 16r2C. " 64-bit encrypted segment information "
	LC_LINKER_OPTION := 16r2D. " linker options in MH_OBJECT files "
	LC_LINKER_OPTIMIZATION_HINT := 16r2E. " optimization hints in MH_OBJECT files "
	LC_VERSION_MIN_TVOS := 16r2F. " build for AppleTV min OS version "
	LC_VERSION_MIN_WATCHOS := 16r30. " build for Watch min OS version "

]

{ #category : #initialization }
SAsmMachConstants class >> initializeCpuConstants [
	CPU_STATE_MAX		:= 4.

	CPU_STATE_USER		:= 0.
	CPU_STATE_SYSTEM	:= 1.
	CPU_STATE_IDLE		:= 2.
	CPU_STATE_NICE		:= 3.


	"Capability bits used in the definition of cpu_type."
	CPU_ARCH_MASK	:= 16rff000000.		"/* mask for architecture bits */"
	CPU_ARCH_ABI64	:= 16r01000000.		"/* 64 bit ABI */"

	"Machine types known by all"
 
	CPU_TYPE_ANY		:= -1.

	CPU_TYPE_VAX		:= 1.
" skip				:=  2)	"
" skip				:=  3)	"
" skip				:=  4)	"
" skip				:=  5)	"
	CPU_TYPE_MC680x0	:= 6.
	CPU_TYPE_X86		:= 7.
	CPU_TYPE_I386		:= CPU_TYPE_X86.		"/* compatibility */"
	CPU_TYPE_X86_64		:= (CPU_TYPE_X86 | CPU_ARCH_ABI64).

"skip CPU_TYPE_MIPS		:=  8)	"
"skip 			:=  9)	"
	CPU_TYPE_MC98000	:= 10.
	CPU_TYPE_HPPA           :=  11.
	CPU_TYPE_ARM		:=  12.
	CPU_TYPE_MC88000	:=  13.
	CPU_TYPE_SPARC		:=  14.
	CPU_TYPE_I860		:=  15.
"skip	CPU_TYPE_ALPHA		:=  16."
"skip				:=  17."
	CPU_TYPE_POWERPC		:=  18.
	CPU_TYPE_POWERPC64		:= (CPU_TYPE_POWERPC | CPU_ARCH_ABI64).

"/*
 *	Machine subtypes (these are defined here, instead of in a machine
 *	dependent directory, so that any program can get all definitions
 *	regardless of where is it compiled).
 */
"
"/*
 * Capability bits used in the definition of cpu_subtype.
 */"
	CPU_SUBTYPE_MASK	:= 16rff000000.	"mask for feature flags"
	CPU_SUBTYPE_LIB64	:= 16r80000000.	"64 bit libraries"


"
 *	Object files that are hand-crafted to run on any
 *	implementation of an architecture are tagged with
 *	CPU_SUBTYPE_MULTIPLE.  This functions essentially the same as
 *	the ""ALL"" subtype of an architecture except that it allows us
 *	to easily find object files that may need to be modified
 *	whenever a new implementation of an architecture comes out.
 *
 *	It is the responsibility of the implementor to make sure the
 *	software handles unsupported implementations elegantly.
 "
	CPU_SUBTYPE_MULTIPLE		:=  -1.
	CPU_SUBTYPE_LITTLE_ENDIAN	:=  0.
	CPU_SUBTYPE_BIG_ENDIAN		:=  1.

"/*
 *     Machine threadtypes.
 *     This is none - not defined - for most machine types/subtypes.
 */"
	CPU_THREADTYPE_NONE		:= 0.

"/*
 *	VAX subtypes (these do *not* necessary conform to the actual cpu
 *	ID assigned by DEC available via the SID register).
 */"

	CPU_SUBTYPE_VAX_ALL	:=  0.
	CPU_SUBTYPE_VAX780	:=  1.
	CPU_SUBTYPE_VAX785	:=  2.
	CPU_SUBTYPE_VAX750	:=  3.
	CPU_SUBTYPE_VAX730	:=  4.
	CPU_SUBTYPE_UVAXI	:=  5.
	CPU_SUBTYPE_UVAXII	:=  6.
	CPU_SUBTYPE_VAX8200	:=  7.
	CPU_SUBTYPE_VAX8500	:=  8.
	CPU_SUBTYPE_VAX8600	:=  9.
	CPU_SUBTYPE_VAX8650	:=  10.
	CPU_SUBTYPE_VAX8800	:=  11.
	CPU_SUBTYPE_UVAXIII	:=  12.

"/*
 * 	680x0 subtypes
 *
 * The subtype definitions here are unusual for historical reasons.
 * NeXT used to consider 68030 code as generic 68000 code.  For
 * backwards compatability:
 * 
 *	CPU_SUBTYPE_MC68030 symbol has been preserved for source code
 *	compatability.
 *
 *	CPU_SUBTYPE_MC680x0_ALL has been defined to be the same
 *	subtype as CPU_SUBTYPE_MC68030 for binary comatability.
 *
 *	CPU_SUBTYPE_MC68030_ONLY has been added to allow new object
 *	files to be tagged as containing 68030-specific instructions.
 */"

	CPU_SUBTYPE_MC680x0_ALL		:=  1.
	CPU_SUBTYPE_MC68030		:=  1. " compat"
	CPU_SUBTYPE_MC68040		:=  2.
	CPU_SUBTYPE_MC68030_ONLY	:=  3.

"/*
 *	I386 subtypes
 */
"
	CPU_SUBTYPE_I386_ALL			:= self cpu_subtype_intel: 3 with: 0.
	CPU_SUBTYPE_386					:= self cpu_subtype_intel: 3 with: 0.
	CPU_SUBTYPE_486					:= self cpu_subtype_intel: 4 with: 0.
	CPU_SUBTYPE_486SX				:= self cpu_subtype_intel: 4 with: 8.	"8 << 4 = 128"
	CPU_SUBTYPE_586					:= self cpu_subtype_intel: 5 with: 0.
	CPU_SUBTYPE_PENT	:= self cpu_subtype_intel: 5 with: 0.
	CPU_SUBTYPE_PENTPRO	:= self cpu_subtype_intel: 6 with: 1.
	CPU_SUBTYPE_PENTII_M3	:= self cpu_subtype_intel: 6 with: 3.
	CPU_SUBTYPE_PENTII_M5	:= self cpu_subtype_intel: 6 with: 5.
	CPU_SUBTYPE_CELERON				:= self cpu_subtype_intel: 7 with: 6.
	CPU_SUBTYPE_CELERON_MOBILE		:= self cpu_subtype_intel: 7 with: 7.
	CPU_SUBTYPE_PENTIUM_3			:= self cpu_subtype_intel: 8 with: 0.
	CPU_SUBTYPE_PENTIUM_3_M			:= self cpu_subtype_intel: 8 with: 1.
	CPU_SUBTYPE_PENTIUM_3_XEON		:= self cpu_subtype_intel: 8 with: 2.
	CPU_SUBTYPE_PENTIUM_M			:= self cpu_subtype_intel: 9 with: 0.
	CPU_SUBTYPE_PENTIUM_4			:= self cpu_subtype_intel: 10 with: 0.
	CPU_SUBTYPE_PENTIUM_4_M			:= self cpu_subtype_intel: 10 with: 1.
	CPU_SUBTYPE_ITANIUM				:= self cpu_subtype_intel: 11 with: 0.
	CPU_SUBTYPE_ITANIUM_2			:= self cpu_subtype_intel: 11 with: 1.
	CPU_SUBTYPE_XEON				:= self cpu_subtype_intel: 12 with: 0.
	CPU_SUBTYPE_XEON_MP				:= self cpu_subtype_intel: 12 with: 1.

	CPU_SUBTYPE_INTEL_FAMILY_MAX	:= 15.

	CPU_SUBTYPE_INTEL_MODEL_ALL	:= 0.

"
X86 subtypes.
"
	CPU_SUBTYPE_X86_ALL		:= 3.
	CPU_SUBTYPE_X86_64_ALL		:= 3.
	CPU_SUBTYPE_X86_ARCH1		:= 4.


	CPU_THREADTYPE_INTEL_HTT	:= 1.

"
 Mips subtypes.
 "

	CPU_SUBTYPE_MIPS_ALL	:=  0.
	CPU_SUBTYPE_MIPS_R2300	:=  1.
	CPU_SUBTYPE_MIPS_R2600	:=  2.
	CPU_SUBTYPE_MIPS_R2800	:=  3.
	CPU_SUBTYPE_MIPS_R2000a	:=  4. "pmax"
	CPU_SUBTYPE_MIPS_R2000	:=  5.
	CPU_SUBTYPE_MIPS_R3000a	:=  6. "3max"
	CPU_SUBTYPE_MIPS_R3000	:=  7.

"
 MC98000 (PowerPC) subtypes
 "
	CPU_SUBTYPE_MC98000_ALL	:=  0.
	CPU_SUBTYPE_MC98601	:=  1.

"
 HPPA subtypes for Hewlett-Packard HP-PA family of
 risc processors. Port by NeXT to 700 series. 
 "

	CPU_SUBTYPE_HPPA_ALL		:=  0.
	CPU_SUBTYPE_HPPA_7100		:=  0. "compat"
	CPU_SUBTYPE_HPPA_7100LC		:=  1.

"
 MC88000 subtypes.
 "
	CPU_SUBTYPE_MC88000_ALL	:=  0.
	CPU_SUBTYPE_MC88100	:=  1.
	CPU_SUBTYPE_MC88110	:=  2.

"/*
 *	SPARC subtypes
 */"
	CPU_SUBTYPE_SPARC_ALL		:=  0.

"/*
 *	I860 subtypes
 */"
	CPU_SUBTYPE_I860_ALL	:=  0.
	CPU_SUBTYPE_I860_860	:=  1.

"/*
 *	PowerPC subtypes
 */"
	CPU_SUBTYPE_POWERPC_ALL		:=  0.
	CPU_SUBTYPE_POWERPC_601		:=  1.
	CPU_SUBTYPE_POWERPC_602		:=  2.
	CPU_SUBTYPE_POWERPC_603		:=  3.
	CPU_SUBTYPE_POWERPC_603e	:=  4.
	CPU_SUBTYPE_POWERPC_603ev	:=  5.
	CPU_SUBTYPE_POWERPC_604		:=  6.
	CPU_SUBTYPE_POWERPC_604e	:=  7.
	CPU_SUBTYPE_POWERPC_620		:=  8.
	CPU_SUBTYPE_POWERPC_750		:=  9.
	CPU_SUBTYPE_POWERPC_7400	:=  10.
	CPU_SUBTYPE_POWERPC_7450	:=  11.
	CPU_SUBTYPE_POWERPC_970		:=  100.

"/*
 *	ARM subtypes
 */"
	CPU_SUBTYPE_ARM_ALL             :=  0.
	CPU_SUBTYPE_ARM_V4T             :=  5.
	CPU_SUBTYPE_ARM_V6              :=  6.
	CPU_SUBTYPE_ARM_V5TEJ           :=  7.
	CPU_SUBTYPE_ARM_XSCALE		:=  8.
	CPU_SUBTYPE_ARM_V7		:=  9.

"/*
 *	CPU families (sysctl hw.cpufamily)
 *
 * These are meant to identify the CPU's marketing name - an
 * application can map these to (possibly) localized strings.
 * NB: the encodings of the CPU families are intentionally arbitrary.
 * There is no ordering, and you should never try to deduce whether
 * or not some feature is available based on the family.
 * Use feature flags (eg, hw.optional.altivec) to test for optional
 * functionality.
 */"
	CPUFAMILY_UNKNOWN   		:= 0.
	CPUFAMILY_POWERPC_G3		:= 16rcee41549.
	CPUFAMILY_POWERPC_G4		:= 16r77c184ae.
	CPUFAMILY_POWERPC_G5		:= 16red76d8aa.
	CPUFAMILY_INTEL_6_13		:= 16raa33392b.
	CPUFAMILY_INTEL_YONAH		:= 16r73d67300.
	CPUFAMILY_INTEL_MEROM		:= 16r426f69ef.
	CPUFAMILY_INTEL_PENRYN		:= 16r78ea4fbc.
	CPUFAMILY_INTEL_NEHALEM		:= 16r6b5a4cd2.
	CPUFAMILY_INTEL_WESTMERE	:= 16r573b5eec.
	CPUFAMILY_ARM_9			:= 16re73283ae.
	CPUFAMILY_ARM_11		:= 16r8ff620d8.
	CPUFAMILY_ARM_XSCALE		:= 16r53b005f5.
	CPUFAMILY_ARM_13		:= 16r0cc90e64.


]

{ #category : #initialization }
SAsmMachConstants class >> initializeHeaderConstants [
	MH_MAGIC	:= 16rfeedface.	"the mach magic number"
	MH_CIGAM	:= 16rcefaedfe.
		
	MH_MAGIC_64 := 16rfeedfacf. "the 64-bit mach magic number"
	MH_CIGAM_64 := 16rcffaedfe. "NXSwapInt(MH_MAGIC_64)"
	
"Constants for the filetype field of the mach_header"
	MH_OBJECT 	:= 16r1.		" relocatable object file "
	MH_EXECUTE	:= 16r2.		" demand paged executable file "
	MH_FVMLIB	:= 16r3.		" fixed VM shared library file "
	MH_CORE		:= 16r4.		" core file "
	MH_PRELOAD	:= 16r5.		" preloaded executable file "
	MH_DYLIB	:= 16r6.		" dynamically bound shared library "
	MH_DYLINKER	:= 16r7.		" dynamic link editor "
	MH_BUNDLE	:= 16r8.		" dynamically bound bundle file "
	MH_DYLIB_STUB	:= 16r9.		" shared library stub for static "
					"  linking only, no section contents "
	MH_DSYM		:= 16ra.		" companion file with only debug "
					"  sections "
	MH_KEXT_BUNDLE	:= 16rb.		" x86_64 kexts "

" Constants for the flags field of the mach_header "
	MH_NOUNDEFS	:= 16r1.		" the object file has no undefined
					   references "
	MH_INCRLINK	:= 16r2.		" the object file is the output of an
					   incremental link against a base file
					   and can't be link edited again "
	MH_DYLDLINK	:= 16r4.		" the object file is input for the
					   dynamic linker and can't be staticly
					   link edited again "
	MH_BINDATLOAD	:= 16r8.		" the object file's undefined
					   references are bound by the dynamic
					   linker when loaded. "
	MH_PREBOUND	:= 16r10.		" the file has its dynamic undefined
					   references prebound. "
	MH_SPLIT_SEGS	:= 16r20.		" the file has its read-only and
					   read-write segments split "
	MH_LAZY_INIT	:= 16r40.		" the shared library init routine is
					   to be run lazily via catching memory
					   faults to its writeable segments
					   (obsolete) "
	MH_TWOLEVEL	:= 16r80.		" the image is using two-level name
					   space bindings "
	MH_FORCE_FLAT	:= 16r100	.	" the executable is forcing all images
					   to use flat name space bindings "
	MH_NOMULTIDEFS	:= 16r200	.	" this umbrella guarantees no multiple
					   defintions of symbols in its
					   sub-images so the two-level namespace
					   hints can always be used. "
	MH_NOFIXPREBINDING := 16r400.	" do not have dyld notify the
					   prebinding agent about this
					   executable "
	MH_PREBINDABLE  := 16r800.           " the binary is not prebound but can
					   have its prebinding redone. only used
                                           when MH_PREBOUND is not set. "
	MH_ALLMODSBOUND := 16r1000.		" indicates that this binary binds to
                                           all two-level namespace modules of
					   its dependent libraries. only used
					   when MH_PREBINDABLE and MH_TWOLEVEL
					   are both set. " 
	MH_SUBSECTIONS_VIA_SYMBOLS := 16r2000." safe to divide up the sections into
					    sub-sections via symbols for dead
					    code stripping "
	MH_CANONICAL    := 16r4000.		" the binary has been canonicalized
					   via the unprebind operation "
	MH_WEAK_DEFINES	:= 16r8000.		" the final linked image contains
					   external weak symbols "
	MH_BINDS_TO_WEAK := 16r10000.	" the final linked image uses
					   weak symbols "

	MH_ALLOW_STACK_EXECUTION := 16r20000." When this bit is set, all stacks 
					   in the task will be given stack
					   execution privilege.  Only used in
					   MH_EXECUTE filetypes. "
	MH_ROOT_SAFE := 16r40000.          " When this bit is set, the binary 
					  declares it is safe for use in
					  processes with uid zero "
                                         
	MH_SETUID_SAFE := 16r80000.         " When this bit is set, the binary 
					  declares it is safe for use in
					  processes when issetugid() is true "

	MH_NO_REEXPORTED_DYLIBS := 16r100000. " When this bit is set on a dylib, 
					  the static linker does not need to
					  examine dependent dylibs to see
					  if any are re-exported "
	MH_PIE := 16r200000.			" When this bit is set, the OS will
					   load the main executable at a
					   random address.  Only used in
					   MH_EXECUTE filetypes. "
	MH_DEAD_STRIPPABLE_DYLIB := 16r400000. " Only for use on dylibs.  When
					     linking against a dylib that
					     has this bit set, the static linker
					     will automatically not create a
					     LC_LOAD_DYLIB load command to the
					     dylib if no symbols are being
					     referenced from the dylib. "
	MH_HAS_TLV_DESCRIPTORS := 16r800000. " Contains a section of type 
					    S_THREAD_LOCAL_VARIABLES "

	MH_NO_HEAP_EXECUTION := 16r1000000.	" When this bit is set, the OS will
					   run the main executable with
					   a non-executable heap even on
					   platforms (e.g. i386) that don't
					   require it. Only used in MH_EXECUTE
					   filetypes. "

	MH_APP_EXTENSION_SAFE := 16r02000000. " The code was linked for use in an
					    application extension. "

]

{ #category : #initialization }
SAsmMachConstants class >> initializeMemoryConstants [
	VM_PROT_NONE	 := 16r00.

	VM_PROT_READ := 16r01.
	VM_PROT_WRITE := 16r02.
	VM_PROT_EXECUTE := 16r04.
]

{ #category : #initialization }
SAsmMachConstants class >> initializeRelocationsConstants [
	R_ABS := 0.
	
	GENERIC_RELOC_VANILLA := 0.
	GENERIC_RELOC_PAIR := 1.
	GENERIC_RELOC_SECTDIFF := 2.
	GENERIC_RELOC_PB_LA_PTR := 3.
	GENERIC_RELOC_LOCAL_SECTDIFF := 4.
	GENERIC_RELOC_TLV := 5.
	
	X86_64_RELOC_UNSIGNED := 0. "for absolute addresses"	       
   X86_64_RELOC_SIGNED := 1. "for signed 32-bit displacement"
	X86_64_RELOC_BRANCH := 2. "a CALL/JMP instruction with 32-bit displacement"   
	X86_64_RELOC_GOT_LOAD := 3. "a MOVQ load of a GOT entry"	   
	X86_64_RELOC_GOT := 4. "other GOT references"	 
	X86_64_RELOC_SUBTRACTOR := 5. "must be followed by a X86_64_RELOC_UNSIGNED"
	X86_64_RELOC_SIGNED_1 := 6. "for signed 32-bit displacement with a -1 addend"
	X86_64_RELOC_SIGNED_2 := 7. "for signed 32-bit displacement with a -2 addend"
	X86_64_RELOC_SIGNED_4 := 8. "for signed 32-bit displacement with a -4 addend"
	X86_64_RELOC_TLV := 9.
]

{ #category : #initialization }
SAsmMachConstants class >> initializeSectionConstants [
"
 * The flags field of a section structure is separated into two parts a section
 * type and section attributes.  The section types are mutually exclusive (it
 * can only have one type) but the section attributes are not (it may have more
 * than one attribute).
 "
	SECTION_TYPE		 := 16r000000ff.	" 256 section types "
	SECTION_ATTRIBUTES	 := 16rffffff00	."  24 section attributes "

" Constants for the type of a section "
	S_REGULAR		:= 16r0.	" regular section "
	S_ZEROFILL		:= 16r1.	" zero fill on demand section "
	S_CSTRING_LITERALS	:= 16r2.	" section with only literal C strings"
	S_4BYTE_LITERALS	:= 16r3.	" section with only 4 byte literals "
	S_8BYTE_LITERALS	:= 16r4.	" section with only 8 byte literals "
	S_LITERAL_POINTERS	:= 16r5.	" section with only pointers to "
					"  literals "
"
 * For the two types of symbol pointers sections and the symbol stubs section
 * they have indirect symbol table entries.  For each of the entries in the
 * section the indirect symbol table entries, in corresponding order in the
 * indirect symbol table, start at the index stored in the reserved1 field
 * of the section structure.  Since the indirect symbol table entries
 * correspond to the entries in the section the number of indirect symbol table
 * entries is inferred from the size of the section divided by the size of the
 * entries in the section.  For symbol pointers sections the size of the entries
 * in the section is 4 bytes and for symbol stubs sections the byte size of the
 * stubs is stored in the reserved2 field of the section structure.
 "
	S_NON_LAZY_SYMBOL_POINTERS	:= 16r6.	" section with only non-lazy
						   symbol pointers "
	S_LAZY_SYMBOL_POINTERS		:= 16r7.	" section with only lazy symbol
						   pointers "
	S_SYMBOL_STUBS			:= 16r8.	" section with only symbol
						   stubs, byte size of stub in
						   the reserved2 field "
	S_MOD_INIT_FUNC_POINTERS	:= 16r9.	" section with only function
						   pointers for initialization"
	S_MOD_TERM_FUNC_POINTERS	:= 16ra.	" section with only function
						   pointers for termination "
	S_COALESCED			:= 16rb.	" section contains symbols that
						   are to be coalesced "
	S_GB_ZEROFILL			:= 16rc.	" zero fill on demand section
						   (that can be larger than 4
						   gigabytes) "
	S_INTERPOSING			:= 16rd.	" section with only pairs of
						   function pointers for
						   interposing "
	S_16BYTE_LITERALS		:= 16re.	" section with only 16 byte
						   literals "
	S_DTRACE_DOF			:= 16rf.	" section contains 
						   DTrace Object Format "
	S_LAZY_DYLIB_SYMBOL_POINTERS	:= 16r10.	" section with only lazy
						   symbol pointers to lazy
						   loaded dylibs "
"
 * Section types to support thread local variables
 "
	S_THREAD_LOCAL_REGULAR                   := 16r11.  " template of initial 
							  values for TLVs "
	S_THREAD_LOCAL_ZEROFILL                  := 16r12.  " template of initial 
							  values for TLVs "
	S_THREAD_LOCAL_VARIABLES                 := 16r13.  " TLV descriptors "
	S_THREAD_LOCAL_VARIABLE_POINTERS         := 16r14.  " pointers to TLV 
                                                          descriptors "
	S_THREAD_LOCAL_INIT_FUNCTION_POINTERS    := 16r15.  " functions to call
							  to initialize TLV
							  values "

"
 * Constants for the section attributes part of the flags field of a section
 * structure.
 "
	SECTION_ATTRIBUTES_USR	 := 16rff000000.	" User setable attributes "
	S_ATTR_PURE_INSTRUCTIONS := 16r80000000.	" section contains only true
						   machine instructions "
	S_ATTR_NO_TOC 		 := 16r40000000.	" section contains coalesced
						   symbols that are not to be
						   in a ranlib table of
						   contents "
	S_ATTR_STRIP_STATIC_SYMS := 16r20000000.	" ok to strip static symbols
						   in this section in files
						   with the MH_DYLDLINK flag "
	S_ATTR_NO_DEAD_STRIP	 := 16r10000000.	" no dead stripping "
	S_ATTR_LIVE_SUPPORT	 := 16r08000000.	" blocks are live if they
						   reference live blocks "
	S_ATTR_SELF_MODIFYING_CODE := 16r04000000.	" Used with i386 code stubs
						   written on by dyld "
"
 * If a segment contains any sections marked with S_ATTR_DEBUG then all
 * sections in that segment must have this attribute.  No section other than
 * a section marked with this attribute may reference the contents of this
 * section.  A section with this attribute may contain no symbols and must have
 * a section type S_REGULAR.  The static linker will not copy section contents
 * from sections with this attribute into its output file.  These sections
 * generally contain DWARF debugging info.
 " 
	S_ATTR_DEBUG		 := 16r02000000.	" a debug section "
	SECTION_ATTRIBUTES_SYS	 := 16r00ffff00.	" system setable attributes "
	S_ATTR_SOME_INSTRUCTIONS := 16r00000400.	" section contains some
						   machine instructions "
	S_ATTR_EXT_RELOC	 := 16r00000200.	" section has external
						   relocation entries "
	S_ATTR_LOC_RELOC	 := 16r00000100.	" section has local
						   relocation entries "
]

{ #category : #initialization }
SAsmMachConstants class >> initializeSegmentConstants [
	"Constants for the flags field of the segment_command"
	SG_HIGHVM := 16r1.	" the file contents for this segment is for
				   the high part of the VM space, the low part
				   is zero filled (for stacks in core files) "
	SG_FVMLIB	:= 16r2.	" this segment is the VM that is allocated by
				   a fixed VM library, for overlap checking in
				   the link editor "
	SG_NORELOC	:= 16r4.	" this segment has nothing that was relocated
				   in it and nothing relocated to it, that is
				   it maybe safely replaced without relocation"
	SG_PROTECTED_VERSION_1	:= 16r8. " This segment is protected.  If the
				       segment starts at file offset 0, the
				       first page of the segment is not
				       protected.  All other pages of the
				       segment are protected. "
				
	SEG_PAGEZERO	:= '__PAGEZERO'.	" the pagezero segment which has no "
					" protections and catches NULL "
					" references for MH_EXECUTE files "


	SEG_TEXT	:= '__TEXT'. " the tradition UNIX text segment "
	SECT_TEXT := '__text'.	" the real text part of the text "
					" section no headers, and no padding "
	SECT_FVMLIB_INIT0 := '__fvmlib_init0'.	" the fvmlib initialization "
						"  section "
	SECT_FVMLIB_INIT1 := '__fvmlib_init1'.	" the section following the "
					        "  fvmlib initialization "
						"  section "

	SEG_DATA	:= '__DATA'.	" the tradition UNIX data segment "
	SECT_DATA := '__data'.	" the real initialized data section "
					" no padding, no bss overlap "
	SECT_BSS	:= '__bss'.		" the real uninitialized data section"
					" no padding "
	SECT_COMMON	:= '__common'.	" the section common symbols are "
					" allocated in by the link editor "

	SEG_OBJC	:= '__OBJC'. 	" objective-C runtime segment "
	SECT_OBJC_SYMBOLS := '__symbol_table'.	" symbol table "
	SECT_OBJC_MODULES := '__module_info'.	" module information "
	SECT_OBJC_STRINGS := '__selector_strs'.	" string table "
	SECT_OBJC_REFS := '__selector_refs'.	" string table "

	SEG_ICON	 := '__ICON'.	" the icon segment "
	SECT_ICON_HEADER := '__header'.	" the icon headers "
	SECT_ICON_TIFF   := '__tiff'.	" the icons in tiff format "

	SEG_LINKEDIT	:= '__LINKEDIT'.	" the segment containing all structs "
					" created and maintained by the link "
					" editor.  Created with -seglinkedit "
					" option to ld(1) for MH_EXECUTE and "
					" FVMLIB file types only "

]

{ #category : #initialization }
SAsmMachConstants class >> initializeSymbolConstants [
	N_STAB := 16re0.  " if any of these bits set, a symbolic debugging entry"
	N_PEXT := 16r10.  " private external symbol bit"
	N_TYPE := 16r0e.  " mask for the type bits"
	N_EXT := 16r01.  " external symbol bit, set for external symbols"

"
 Values for N_TYPE bits of the n_type field.
 "
	N_UNDF	:= 16r0.		" undefined, n_sect == NO_SECT "
	N_ABS	:= 16r2.		" absolute, n_sect == NO_SECT "
	N_SECT	:= 16re.		" defined in section number n_sect "
	N_PBUD	:= 16rc.		" prebound undefined (defined in a dylib) "
	N_INDR	:= 16ra.		" indirect "
				
	REFERENCE_TYPE := 16r7.
	REFERENCE_FLAG_UNDEFINED_NON_LAZY := 0.
	REFERENCE_FLAG_UNDEFINED_LAZY := 1.
	REFERENCE_FLAG_DEFINED := 2.
	REFERENCE_FLAG_PRIVATE_DEFINED := 3.
	REFERENCE_FLAG_PRIVATE_UNDEFINED_NON_LAZY := 4.
	REFERENCE_FLAG_PRIVATE_UNDEFINED_LAZY := 5.
	
	NO_SECT := 0. " symbol is not in any section "
	MAX_SEC := 255.	" 1 thru 255 inclusive "
]
