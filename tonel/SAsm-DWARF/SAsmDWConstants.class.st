Class {
	#name : #SAsmDWConstants,
	#superclass : #SharedPool,
	#classVars : [
		'DW_ACCESS_private',
		'DW_ACCESS_protected',
		'DW_ACCESS_public',
		'DW_ATE_ASCII',
		'DW_ATE_UCS',
		'DW_ATE_UTF',
		'DW_ATE_address',
		'DW_ATE_boolean',
		'DW_ATE_complex_float',
		'DW_ATE_decimal_float',
		'DW_ATE_edited',
		'DW_ATE_float',
		'DW_ATE_hi_user',
		'DW_ATE_imaginary_float',
		'DW_ATE_lo_user',
		'DW_ATE_numeric_string',
		'DW_ATE_packed_decimal',
		'DW_ATE_signed',
		'DW_ATE_signed_char',
		'DW_ATE_signed_fixed',
		'DW_ATE_unsigned',
		'DW_ATE_unsigned_char',
		'DW_ATE_unsigned_fixed',
		'DW_AT_abstract_origin',
		'DW_AT_accessibility',
		'DW_AT_addr_base',
		'DW_AT_address_class',
		'DW_AT_alignment',
		'DW_AT_allocated',
		'DW_AT_artificial',
		'DW_AT_associated',
		'DW_AT_base_types',
		'DW_AT_binary_scale',
		'DW_AT_bit_size',
		'DW_AT_bit_stride',
		'DW_AT_byte_size',
		'DW_AT_byte_stride',
		'DW_AT_call_all_calls',
		'DW_AT_call_all_source_calls',
		'DW_AT_call_all_tail_calls',
		'DW_AT_call_column',
		'DW_AT_call_data_location',
		'DW_AT_call_data_value',
		'DW_AT_call_file',
		'DW_AT_call_line',
		'DW_AT_call_origin',
		'DW_AT_call_parameter',
		'DW_AT_call_pc',
		'DW_AT_call_return_pc',
		'DW_AT_call_tail_call',
		'DW_AT_call_target',
		'DW_AT_call_target_clobbered',
		'DW_AT_call_value',
		'DW_AT_calling_convention',
		'DW_AT_common_reference',
		'DW_AT_comp_dir',
		'DW_AT_const_expr',
		'DW_AT_const_value',
		'DW_AT_containing_type',
		'DW_AT_count',
		'DW_AT_data_bit_offset',
		'DW_AT_data_location',
		'DW_AT_data_member_location',
		'DW_AT_decimal_scale',
		'DW_AT_decimal_sign',
		'DW_AT_decl_column',
		'DW_AT_decl_file',
		'DW_AT_decl_line',
		'DW_AT_declaration',
		'DW_AT_default_value',
		'DW_AT_defaulted',
		'DW_AT_deleted',
		'DW_AT_description',
		'DW_AT_digit_count',
		'DW_AT_discr',
		'DW_AT_discr_list',
		'DW_AT_discr_value',
		'DW_AT_dwo_name',
		'DW_AT_elemental',
		'DW_AT_encoding',
		'DW_AT_endianity',
		'DW_AT_entry_pc',
		'DW_AT_enum_class',
		'DW_AT_explicit',
		'DW_AT_export_symbols',
		'DW_AT_extension',
		'DW_AT_external',
		'DW_AT_frame_base',
		'DW_AT_friend',
		'DW_AT_hi_user',
		'DW_AT_high_pc',
		'DW_AT_identifier_case',
		'DW_AT_import',
		'DW_AT_inline',
		'DW_AT_is_optional',
		'DW_AT_language',
		'DW_AT_linkage_name',
		'DW_AT_lo_user',
		'DW_AT_location',
		'DW_AT_loclists_base',
		'DW_AT_low_pc',
		'DW_AT_lower_bound',
		'DW_AT_macros',
		'DW_AT_main_subprogram',
		'DW_AT_mutable',
		'DW_AT_name',
		'DW_AT_namelist_item',
		'DW_AT_noreturn',
		'DW_AT_object_pointer',
		'DW_AT_ordering',
		'DW_AT_picture_string',
		'DW_AT_priority',
		'DW_AT_producer',
		'DW_AT_prototyped',
		'DW_AT_pure',
		'DW_AT_ranges',
		'DW_AT_rank',
		'DW_AT_recursive',
		'DW_AT_reference',
		'DW_AT_return_addr',
		'DW_AT_rnglists_base',
		'DW_AT_rvalue_reference',
		'DW_AT_segment',
		'DW_AT_sibling',
		'DW_AT_signature',
		'DW_AT_small',
		'DW_AT_specification',
		'DW_AT_start_scope',
		'DW_AT_static_link',
		'DW_AT_stmt_list',
		'DW_AT_str_offsets_base',
		'DW_AT_string_length',
		'DW_AT_string_length_bit_size',
		'DW_AT_string_length_byte_size',
		'DW_AT_threads_scaled',
		'DW_AT_trampoline',
		'DW_AT_type',
		'DW_AT_upper_bound',
		'DW_AT_use_UTF8',
		'DW_AT_use_location',
		'DW_AT_variable_parameter',
		'DW_AT_virtuality',
		'DW_AT_visibility',
		'DW_AT_vtable_elem_location',
		'DW_CC_lo_user',
		'DW_CC_nocall',
		'DW_CC_normal',
		'DW_CC_pass_by_reference',
		'DW_CC_pass_by_value',
		'DW_CC_program',
		'DW_CHILDREN_no',
		'DW_CHILDREN_yes',
		'DW_DEFAULTED_in_class',
		'DW_DEFAULTED_no',
		'DW_DEFAULTED_out_of_class',
		'DW_DSC_label',
		'DW_DSC_range',
		'DW_DS_leading_overpunch',
		'DW_DS_leading_separate',
		'DW_DS_trailing_overpunch',
		'DW_DS_trailing_separate',
		'DW_DS_unsigned',
		'DW_END_big',
		'DW_END_default',
		'DW_END_hi_user',
		'DW_END_little',
		'DW_END_lo_user',
		'DW_FORM_addr',
		'DW_FORM_addrx',
		'DW_FORM_addrx1',
		'DW_FORM_addrx2',
		'DW_FORM_addrx3',
		'DW_FORM_addrx4',
		'DW_FORM_block',
		'DW_FORM_block1',
		'DW_FORM_block2',
		'DW_FORM_block4',
		'DW_FORM_data1',
		'DW_FORM_data16',
		'DW_FORM_data2',
		'DW_FORM_data4',
		'DW_FORM_data8',
		'DW_FORM_exprloc',
		'DW_FORM_flag',
		'DW_FORM_flag_present',
		'DW_FORM_implicit_const',
		'DW_FORM_indirect',
		'DW_FORM_line_strp',
		'DW_FORM_loclistx',
		'DW_FORM_ref1',
		'DW_FORM_ref2',
		'DW_FORM_ref4',
		'DW_FORM_ref8',
		'DW_FORM_ref_addr',
		'DW_FORM_ref_sig8',
		'DW_FORM_ref_sup4',
		'DW_FORM_ref_sup8',
		'DW_FORM_ref_udata',
		'DW_FORM_rnglistx',
		'DW_FORM_sdata',
		'DW_FORM_sec_offset',
		'DW_FORM_string',
		'DW_FORM_strp',
		'DW_FORM_strp_sup',
		'DW_FORM_strx',
		'DW_FORM_strx1',
		'DW_FORM_strx2',
		'DW_FORM_strx3',
		'DW_FORM_strx4',
		'DW_FORM_udata',
		'DW_IDX_compile_unit',
		'DW_IDX_die_offset',
		'DW_IDX_hi_user',
		'DW_IDX_lo_user',
		'DW_IDX_parent',
		'DW_IDX_type_hash',
		'DW_IDX_type_unit',
		'DW_ID_case_insensitive',
		'DW_ID_case_sensitive',
		'DW_ID_down_case',
		'DW_ID_up_case',
		'DW_INL_declared_inlined',
		'DW_INL_declared_not_inlined',
		'DW_INL_inlined',
		'DW_INL_not_inlined',
		'DW_LANG_Ada83',
		'DW_LANG_Ada95',
		'DW_LANG_BLISS',
		'DW_LANG_C',
		'DW_LANG_C11',
		'DW_LANG_C89',
		'DW_LANG_C99',
		'DW_LANG_C_plus_plus',
		'DW_LANG_C_plus_plus_03',
		'DW_LANG_C_plus_plus_11',
		'DW_LANG_C_plus_plus_14',
		'DW_LANG_Cobol74',
		'DW_LANG_Cobol85',
		'DW_LANG_D',
		'DW_LANG_Dylan',
		'DW_LANG_Fortran03',
		'DW_LANG_Fortran08',
		'DW_LANG_Fortran77',
		'DW_LANG_Fortran90',
		'DW_LANG_Fortran95',
		'DW_LANG_Go',
		'DW_LANG_Haskell',
		'DW_LANG_Java',
		'DW_LANG_Julia',
		'DW_LANG_Modula2',
		'DW_LANG_Modula3',
		'DW_LANG_OCaml',
		'DW_LANG_ObjC',
		'DW_LANG_ObjC_plus_plus',
		'DW_LANG_OpenCL',
		'DW_LANG_PLI',
		'DW_LANG_Pascal83',
		'DW_LANG_Python',
		'DW_LANG_RenderScript',
		'DW_LANG_Rust',
		'DW_LANG_Swift',
		'DW_LANG_UPC',
		'DW_LANG_hi_user',
		'DW_LANG_lo_user',
		'DW_LLE_base_address',
		'DW_LLE_base_addressx',
		'DW_LLE_default_location',
		'DW_LLE_end_of_list',
		'DW_LLE_offset_pair',
		'DW_LLE_start_end',
		'DW_LLE_start_length',
		'DW_LLE_startx_endx',
		'DW_LLE_startx_length',
		'DW_LNCT_MD5',
		'DW_LNCT_directory_index',
		'DW_LNCT_hi_user',
		'DW_LNCT_lo_user',
		'DW_LNCT_path',
		'DW_LNCT_size',
		'DW_LNCT_timestamp',
		'DW_LNE_end_sequence',
		'DW_LNE_hi_user',
		'DW_LNE_lo_user',
		'DW_LNE_set_address',
		'DW_LNE_set_discriminator',
		'DW_LNS_advance_line',
		'DW_LNS_advance_pc',
		'DW_LNS_const_add_pc',
		'DW_LNS_copy',
		'DW_LNS_fixed_advance_pc',
		'DW_LNS_negate_stmt',
		'DW_LNS_set_basic_block',
		'DW_LNS_set_column',
		'DW_LNS_set_epilogue_begin',
		'DW_LNS_set_file',
		'DW_LNS_set_isa',
		'DW_LNS_set_prologue_end',
		'DW_MACRO_define',
		'DW_MACRO_define_strp',
		'DW_MACRO_define_strx',
		'DW_MACRO_define_sup',
		'DW_MACRO_end_file',
		'DW_MACRO_hi_user',
		'DW_MACRO_import',
		'DW_MACRO_import_sup',
		'DW_MACRO_lo_user',
		'DW_MACRO_start_file',
		'DW_MACRO_undef',
		'DW_MACRO_undef_strp',
		'DW_MACRO_undef_strx',
		'DW_MACRO_undef_sup',
		'DW_OP_addr',
		'DW_OP_breg0',
		'DW_OP_bregx',
		'DW_OP_const1s',
		'DW_OP_const1u',
		'DW_OP_const2s',
		'DW_OP_const2u',
		'DW_OP_const4s',
		'DW_OP_const4u',
		'DW_OP_const8s',
		'DW_OP_const8u',
		'DW_OP_const_type',
		'DW_OP_consts',
		'DW_OP_constu',
		'DW_OP_convert',
		'DW_OP_deref',
		'DW_OP_deref_type',
		'DW_OP_drop',
		'DW_OP_dup',
		'DW_OP_entry_value',
		'DW_OP_fbreg',
		'DW_OP_hi_user',
		'DW_OP_lo_user',
		'DW_OP_over',
		'DW_OP_pick',
		'DW_OP_reg0',
		'DW_OP_regval_type',
		'DW_OP_regx',
		'DW_OP_reinterpret',
		'DW_OP_swap',
		'DW_OP_xderef_type',
		'DW_ORD_col_major',
		'DW_ORD_row_major',
		'DW_RLE_base_address',
		'DW_RLE_base_addressx',
		'DW_RLE_end_of_list',
		'DW_RLE_offset_pair',
		'DW_RLE_start_end',
		'DW_RLE_start_length',
		'DW_RLE_startx_endx',
		'DW_RLE_startx_length',
		'DW_SECT_ABBREV',
		'DW_SECT_INFO',
		'DW_SECT_LINE',
		'DW_SECT_LOCLISTS',
		'DW_SECT_MACRO',
		'DW_SECT_RNGLISTS',
		'DW_SECT_STR_OFFSETS',
		'DW_TAG_access_declaration',
		'DW_TAG_array_type',
		'DW_TAG_atomic_type',
		'DW_TAG_base_type',
		'DW_TAG_call_site',
		'DW_TAG_call_site_parameter',
		'DW_TAG_catch_block',
		'DW_TAG_class_type',
		'DW_TAG_coarray_type',
		'DW_TAG_common_block',
		'DW_TAG_common_inclusion',
		'DW_TAG_compile_unit',
		'DW_TAG_condition',
		'DW_TAG_const_type',
		'DW_TAG_constant',
		'DW_TAG_dwarf_procedure',
		'DW_TAG_dynamic_type',
		'DW_TAG_entry_point',
		'DW_TAG_enumeration_type',
		'DW_TAG_enumerator',
		'DW_TAG_file_type',
		'DW_TAG_formal_parameter',
		'DW_TAG_friend',
		'DW_TAG_generic_subrange',
		'DW_TAG_hi_user',
		'DW_TAG_immutable_type',
		'DW_TAG_imported_declaration',
		'DW_TAG_imported_module',
		'DW_TAG_imported_unit',
		'DW_TAG_inheritance',
		'DW_TAG_inlined_subroutine',
		'DW_TAG_interface_type',
		'DW_TAG_label',
		'DW_TAG_lexical_block',
		'DW_TAG_lo_user',
		'DW_TAG_member',
		'DW_TAG_module',
		'DW_TAG_namelist',
		'DW_TAG_namelist_item',
		'DW_TAG_namespace',
		'DW_TAG_packed_type',
		'DW_TAG_partial_unit',
		'DW_TAG_pointer_type',
		'DW_TAG_ptr_to_member_type',
		'DW_TAG_reference_type',
		'DW_TAG_restrict_type',
		'DW_TAG_rvalue_reference_type',
		'DW_TAG_set_type',
		'DW_TAG_shared_type',
		'DW_TAG_skeleton_unit',
		'DW_TAG_string_type',
		'DW_TAG_structure_type',
		'DW_TAG_subprogram',
		'DW_TAG_subrange_type',
		'DW_TAG_subroutine_type',
		'DW_TAG_template_alias',
		'DW_TAG_template_type_parameter',
		'DW_TAG_template_value_parameter',
		'DW_TAG_thrown_type',
		'DW_TAG_try_block',
		'DW_TAG_type_unit',
		'DW_TAG_typedef',
		'DW_TAG_union_type',
		'DW_TAG_unspecified_parameters',
		'DW_TAG_unspecified_type',
		'DW_TAG_variable',
		'DW_TAG_variant',
		'DW_TAG_variant_part',
		'DW_TAG_volatile_type',
		'DW_TAG_with_stmt',
		'DW_UT_compile',
		'DW_UT_hi_user',
		'DW_UT_lo_user',
		'DW_UT_partial',
		'DW_UT_skeleton',
		'DW_UT_split_compile',
		'DW_UT_split_type',
		'DW_UT_type',
		'DW_VIRTUALITY_none',
		'DW_VIRTUALITY_pure_virtual',
		'DW_VIRTUALITY_virtual',
		'DW_VIS_exported',
		'DW_VIS_local',
		'DW_VIS_qualified'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #'as yet unclassified' }
SAsmDWConstants class >> dwarfConstantsDescription [
	^ #(
		(DW_SECT_INFO 1 '.debug_info.dwo')
		(DW_SECT_ABBREV 3 '.debug_abbrev.dwo')
		(DW_SECT_LINE 4 '.debug_line.dwo')
		(DW_SECT_LOCLISTS 5 '.debug_loclists.dwo')
		(DW_SECT_STR_OFFSETS 6 '.debug_str_offsets.d')
		(DW_SECT_MACRO 7 '.debug_macro.dwo')
		(DW_SECT_RNGLISTS 8 '.debug_rnglists.dwo')
		
		(DW_UT_compile  1)
		(DW_UT_type  2)
		(DW_UT_partial  3)
		(DW_UT_skeleton  4)
		(DW_UT_split_compile  5)
		(DW_UT_split_type  6)
		(DW_UT_lo_user  128)
		(DW_UT_hi_user  15)
		
		(DW_TAG_array_type 1)
		(DW_TAG_class_type 2)
		(DW_TAG_entry_point 3)
		(DW_TAG_enumeration_type 4)
		(DW_TAG_formal_parameter 5)
		(DW_TAG_imported_declaration 8)
		(DW_TAG_label 10)
		(DW_TAG_lexical_block 11)
		(DW_TAG_member 13)
		(DW_TAG_pointer_type 15)
		(DW_TAG_reference_type 16)
		(DW_TAG_compile_unit 17)
		(DW_TAG_string_type 18)
		(DW_TAG_structure_type 19)
		(DW_TAG_subroutine_type 21)
		(DW_TAG_typedef 22)
		(DW_TAG_union_type 23)
		(DW_TAG_unspecified_parameters 24)
		(DW_TAG_variant 25)
		(DW_TAG_common_block 26)
		(DW_TAG_common_inclusion 27)
		(DW_TAG_inheritance 28)
		(DW_TAG_inlined_subroutine 29)
		(DW_TAG_module 30)
		(DW_TAG_ptr_to_member_type 31)
		(DW_TAG_set_type 32)
		(DW_TAG_subrange_type 33)
		(DW_TAG_with_stmt 34)
		(DW_TAG_access_declaration 35)
		(DW_TAG_base_type 36)
		(DW_TAG_catch_block 37)
		(DW_TAG_const_type 38)
		(DW_TAG_constant 39)
		(DW_TAG_enumerator 40)
		(DW_TAG_file_type 41)
		(DW_TAG_friend 42)
		(DW_TAG_namelist 43)
		(DW_TAG_namelist_item 44)
		(DW_TAG_packed_type 45)
		(DW_TAG_subprogram 46)
		(DW_TAG_template_type_parameter 47)
		(DW_TAG_template_value_parameter 48)
		(DW_TAG_thrown_type 49)
		(DW_TAG_try_block 50)
		(DW_TAG_variant_part 51)
		(DW_TAG_variable 52)
		(DW_TAG_volatile_type 53)
		(DW_TAG_dwarf_procedure 54)
		(DW_TAG_restrict_type 55)
		(DW_TAG_interface_type 56)
		(DW_TAG_namespace 57)
		(DW_TAG_imported_module 58)
		(DW_TAG_unspecified_type 59)
		(DW_TAG_partial_unit 60)
		(DW_TAG_imported_unit 61)
		(DW_TAG_condition 63)
		(DW_TAG_shared_type 64)
		(DW_TAG_type_unit 65)
		(DW_TAG_rvalue_reference_type 66)
		(DW_TAG_template_alias 67)
		(DW_TAG_coarray_type  68)
		(DW_TAG_generic_subrange  69)
		(DW_TAG_dynamic_type  70)
		(DW_TAG_atomic_type  71)
		(DW_TAG_call_site  72)
		(DW_TAG_call_site_parameter  73)
		(DW_TAG_skeleton_unit  74)
		(DW_TAG_immutable_type  75)
		(DW_TAG_lo_user 1032)
		(DW_TAG_hi_user 15)
		
		(DW_CHILDREN_no 0)
		(DW_CHILDREN_yes 1)
		
		(DW_AT_sibling 1 'reference')
		(DW_AT_location 2 '"exprloc' ' loclist"')
		(DW_AT_name 3 'string')
		(DW_AT_ordering 9 'constant')
		(DW_AT_byte_size 11 '"constant' ' exprloc' ' reference"')
		(DW_AT_bit_size 13 '"constant' ' exprloc' ' reference"')
		(DW_AT_stmt_list 16 'lineptr')
		(DW_AT_low_pc 17 'address')
		(DW_AT_high_pc 18 '"address' ' constant"')
		(DW_AT_language 19 'constant')
		(DW_AT_discr 21 'reference')
		(DW_AT_discr_value 22 'constant')
		(DW_AT_visibility 23 'constant')
		(DW_AT_import 24 'reference')
		(DW_AT_string_length 25 '"exprloc' ' loclist' ' reference"')
		(DW_AT_common_reference 26 'reference')
		(DW_AT_comp_dir 27 'string')
		(DW_AT_const_value 28 '"block' ' constant' ' string"')
		(DW_AT_containing_type 29 'reference')
		(DW_AT_default_value 30 '"constant' ' reference' ' flag"')
		(DW_AT_inline 32 'constant')
		(DW_AT_is_optional 33 'flag')
		(DW_AT_lower_bound 34 '"constant' ' exprloc' ' reference"')
		(DW_AT_producer 37 'string')
		(DW_AT_prototyped 39 'flag')
		(DW_AT_return_addr 42 '"exprloc' ' loclist"')
		(DW_AT_start_scope 44 '"constant' ' rnglist"')
		(DW_AT_bit_stride 46 '"constant' ' exprloc' ' reference"')
		(DW_AT_upper_bound 47 '"constant' ' exprloc' ' reference"')
		(DW_AT_abstract_origin 49 'reference')
		(DW_AT_accessibility 50 'constant')
		(DW_AT_address_class 51 'constant')
		(DW_AT_artificial 52 'flag')
		(DW_AT_base_types 53 'reference')
		(DW_AT_calling_convention 54 'constant')
		(DW_AT_count 55 '"constant' ' exprloc' ' reference"')
		(DW_AT_data_member_location 56 '"constant' ' exprloc' ' loclist"')
		(DW_AT_decl_column 57 'constant')
		(DW_AT_decl_file 58 'constant')
		(DW_AT_decl_line 59 'constant')
		(DW_AT_declaration 60 'flag')
		(DW_AT_discr_list 61 'block')
		(DW_AT_encoding 62 'constant')
		(DW_AT_external 63 'flag')
		(DW_AT_frame_base 64 '"exprloc' ' loclist"')
		(DW_AT_friend 65 'reference')
		(DW_AT_identifier_case 66 'constant')
		(DW_AT_namelist_item 68 'reference')
		(DW_AT_priority 69 'reference')
		(DW_AT_segment 70 '"exprloc' ' loclist"')
		(DW_AT_specification 71 'reference')
		(DW_AT_static_link 72 '"exprloc' ' loclist"')
		(DW_AT_type 73 'reference')
		(DW_AT_use_location 74 '"exprloc' ' loclist"')
		(DW_AT_variable_parameter 75 'flag')
		(DW_AT_virtuality 76 'constant')
		(DW_AT_vtable_elem_location 77 '"exprloc' ' loclist"')
		(DW_AT_allocated 78 '"constant' ' exprloc' ' reference"')
		(DW_AT_associated 79 '"constant' ' exprloc' ' reference"')
		(DW_AT_data_location 80 'exprloc')
		(DW_AT_byte_stride 81 '"constant' ' exprloc' ' reference"')
		(DW_AT_entry_pc 82 '"address' ' constant"')
		(DW_AT_use_UTF8 83 'flag')
		(DW_AT_extension 84 'reference')
		(DW_AT_ranges 85 'rnglist')
		(DW_AT_trampoline 86 '"address' ' flag' ' reference' ' string"')
		(DW_AT_call_column 87 'constant')
		(DW_AT_call_file 88 'constant')
		(DW_AT_call_line 89 'constant')
		(DW_AT_description 90 'string')
		(DW_AT_binary_scale 91 'constant')
		(DW_AT_decimal_scale 92 'constant')
		(DW_AT_small 93 'reference')
		(DW_AT_decimal_sign 94 'constant')
		(DW_AT_digit_count 95 'constant')
		(DW_AT_picture_string 96 'string')
		(DW_AT_mutable 97 'flag')
		(DW_AT_threads_scaled 98 'flag')
		(DW_AT_explicit 99 'flag')
		(DW_AT_object_pointer 100 'reference')
		(DW_AT_endianity 101 'constant')
		(DW_AT_elemental 102 'flag')
		(DW_AT_pure 103 'flag')
		(DW_AT_recursive 104 'flag')
		(DW_AT_signature 105 'reference')
		(DW_AT_main_subprogram 106 'flag')
		(DW_AT_data_bit_offset 107 'constant')
		(DW_AT_const_expr 108 'flag')
		(DW_AT_enum_class 109 'flag')
		(DW_AT_linkage_name 110 'string')
		(DW_AT_string_length_bit_size  111 'constant')
		(DW_AT_string_length_byte_size  112 'constant')
		(DW_AT_rank  113 '"constant' ' exprloc"')
		(DW_AT_str_offsets_base  114 'stroffsetsptr')
		(DW_AT_addr_base  115 'addrptr')
		(DW_AT_rnglists_base  116 'rnglistsptr')
		(DW_AT_dwo_name  118 'string')
		(DW_AT_reference  119 'flag')
		(DW_AT_rvalue_reference  120 'flag')
		(DW_AT_macros  121 'macptr')
		(DW_AT_call_all_calls  122 'flag')
		(DW_AT_call_all_source_calls  123 'flag')
		(DW_AT_call_all_tail_calls  124 'flag')
		(DW_AT_call_return_pc  125 'address')
		(DW_AT_call_value  126 'exprloc')
		(DW_AT_call_origin  127 'exprloc')
		(DW_AT_call_parameter  128 'reference')
		(DW_AT_call_pc  129 'address')
		(DW_AT_call_tail_call  130 'flag')
		(DW_AT_call_target  131 'exprloc')
		(DW_AT_call_target_clobbered  132 'exprloc')
		(DW_AT_call_data_location  133 'exprloc')
		(DW_AT_call_data_value  134 'exprloc')
		(DW_AT_noreturn  135 'flag')
		(DW_AT_alignment  136 'constant')
		(DW_AT_export_symbols  137 'flag')
		(DW_AT_deleted  138 'flag')
		(DW_AT_defaulted  139 'constant')
		(DW_AT_loclists_base  140 'loclistsptr')
		(DW_AT_lo_user 8192 '—')
		(DW_AT_hi_user 63 '—')
		
		(DW_FORM_addr 1 'address')
		(DW_FORM_block2 3 'block')
		(DW_FORM_block4 4 'block')
		(DW_FORM_data2 5 'constant')
		(DW_FORM_data4 6 'constant')
		(DW_FORM_data8 7 'constant')
		(DW_FORM_string 8 'string')
		(DW_FORM_block 9 'block')
		(DW_FORM_block1 10 'block')
		(DW_FORM_data1 11 'constant')
		(DW_FORM_flag 12 'flag')
		(DW_FORM_sdata 13 'constant')
		(DW_FORM_strp 14 'string')
		(DW_FORM_udata 15 'constant')
		(DW_FORM_ref_addr 16 'reference')
		(DW_FORM_ref1 17 'reference')
		(DW_FORM_ref2 18 'reference')
		(DW_FORM_ref4 19 'reference')
		(DW_FORM_ref8 20 'reference')
		(DW_FORM_ref_udata 21 'reference')
		(DW_FORM_indirect 22 '(see Section 7.5.3 on page 203)')
		(DW_FORM_sec_offset 23 '"addrptr' ' lineptr' ' loclist' ' loclistsptr' '"')
		(DW_FORM_exprloc 24 'exprloc')
		(DW_FORM_flag_present 25 'flag')
		(DW_FORM_strx  26 'string')
		(DW_FORM_addrx  27 'address')
		(DW_FORM_ref_sup4  28 'reference')
		(DW_FORM_strp_sup  29 'string')
		(DW_FORM_data16  30 'constant')
		(DW_FORM_line_strp  31 'string')
		(DW_FORM_ref_sig8 32 'reference')
		(DW_FORM_implicit_const  33 'constant')
		(DW_FORM_loclistx  34 'loclist')
		(DW_FORM_rnglistx  35 'rnglist')
		(DW_FORM_ref_sup8  36 'reference')
		(DW_FORM_strx1  37 'string')
		(DW_FORM_strx2  38 'string')
		(DW_FORM_strx3  39 'string')
		(DW_FORM_strx4  40 'string')
		(DW_FORM_addrx1  41 'address')
		(DW_FORM_addrx2  42 'address')
		(DW_FORM_addrx3  43 'address')
		(DW_FORM_addrx4  44 'address')
		
		(DW_OP_addr 3 '1' 'constant address')
		(DW_OP_deref 6 '0' '')
		(DW_OP_const1u 8 '1' '1-byte constant')
		(DW_OP_const1s 9 '1' '1-byte constant')
		(DW_OP_const2u 10 '1' '2-byte constant')
		(DW_OP_const2s 11 '1' '2-byte constant')
		(DW_OP_const4u 12 '1' '4-byte constant')
		(DW_OP_const4s 13 '1' '4-byte constant')
		(DW_OP_const8u 14 '1' '8-byte constant')
		(DW_OP_const8s 15 '1' '8-byte constant')
		(DW_OP_constu 16 '1' 'ULEB128 constant')
		(DW_OP_consts 17 '1' 'SLEB128 constant')
		(DW_OP_dup 18 '0' '')
		(DW_OP_drop 19 '0' '')
		(DW_OP_over 20 '0' '')
		(DW_OP_pick 21 '1' '1-byte stack index')
		(DW_OP_swap 22 '0' '')
		(DW_OP_reg0 16r50 '0' '')
		(DW_OP_breg0 16r70 '1' '')
		(DW_OP_regx 16r90 '1' '')
		(DW_OP_fbreg 16r91 '1' '')
		(DW_OP_bregx 16r92 '1' '')
		(DW_OP_entry_value  163 '2' '"ULEB128 size' '"')
		(DW_OP_const_type  164 '3' '"ULEB128 type entry offset' '"')
		(DW_OP_regval_type  165 '2' '"ULEB128 register number' '"')
		(DW_OP_deref_type  166 '2' '"1-byte size' '"')
		(DW_OP_xderef_type  167 '2' '"1-byte size' '"')
		(DW_OP_convert  168 '1' 'ULEB128 type entry offset')
		(DW_OP_reinterpret  169 '1' 'ULEB128 type entry offset')
		(DW_OP_lo_user 224 '' '')
		(DW_OP_hi_user 15 '' '')
		
		(DW_LLE_end_of_list  0)
		(DW_LLE_base_addressx  1)
		(DW_LLE_startx_endx  2)
		(DW_LLE_startx_length  3)
		(DW_LLE_offset_pair  4)
		(DW_LLE_default_location  5)
		(DW_LLE_base_address  6)
		(DW_LLE_start_end  7)
		(DW_LLE_start_length  8)
		
		(DW_ATE_address 1)
		(DW_ATE_boolean 2)
		(DW_ATE_complex_float 3)
		(DW_ATE_float 4)
		(DW_ATE_signed 5)
		(DW_ATE_signed_char 6)
		(DW_ATE_unsigned 7)
		(DW_ATE_unsigned_char 8)
		(DW_ATE_imaginary_float 9)
		(DW_ATE_packed_decimal 10)
		(DW_ATE_numeric_string 11)
		(DW_ATE_edited 12)
		(DW_ATE_signed_fixed 13)
		(DW_ATE_unsigned_fixed 14)
		(DW_ATE_decimal_float 15)
		(DW_ATE_UTF 16)
		(DW_ATE_UCS  17)
		(DW_ATE_ASCII  18)
		(DW_ATE_lo_user 128)
		(DW_ATE_hi_user 15)
		
		(DW_DS_unsigned 1)
		(DW_DS_leading_overpunch 2)
		(DW_DS_trailing_overpunch 3)
		(DW_DS_leading_separate 4)
		(DW_DS_trailing_separate 5)
		
		(DW_END_default 0)
		(DW_END_big 1)
		(DW_END_little 2)
		(DW_END_lo_user 64)
		(DW_END_hi_user 15)
		
		(DW_ACCESS_public 1)
		(DW_ACCESS_protected 2)
		(DW_ACCESS_private 3)
		
		(DW_VIS_local 1)
		(DW_VIS_exported 2)
		(DW_VIS_qualified 3)
		
		(DW_VIRTUALITY_none 0)
		(DW_VIRTUALITY_virtual 1)
		(DW_VIRTUALITY_pure_virtual 2)
		
		(DW_LANG_C89 1 '0')
		(DW_LANG_C 2 '0')
		(DW_LANG_Ada83  3 '1')
		(DW_LANG_C_plus_plus 4 '0')
		(DW_LANG_Cobol74  5 '1')
		(DW_LANG_Cobol85  6 '1')
		(DW_LANG_Fortran77 7 '1')
		(DW_LANG_Fortran90 8 '1')
		(DW_LANG_Pascal83 9 '1')
		(DW_LANG_Modula2 10 '1')
		(DW_LANG_Java 11 '0')
		(DW_LANG_C99 12 '0')
		(DW_LANG_Ada95  13 '1')
		(DW_LANG_Fortran95 14 '1')
		(DW_LANG_PLI  15 '1')
		(DW_LANG_ObjC 16 '0')
		(DW_LANG_ObjC_plus_plus 17 '0')
		(DW_LANG_UPC 18 '0')
		(DW_LANG_D 19 '0')
		(DW_LANG_Python  20 '0')
		(DW_LANG_OpenCL  21 '0')
		(DW_LANG_Go  22 '0')
		(DW_LANG_Modula3  23 '1')
		(DW_LANG_Haskell  24 '0')
		(DW_LANG_C_plus_plus_03  25 '0')
		(DW_LANG_C_plus_plus_11  26 '0')
		(DW_LANG_OCaml  27 '0')
		(DW_LANG_Rust  28 '0')
		(DW_LANG_C11  29 '0')
		(DW_LANG_Swift  30 '0')
		(DW_LANG_Julia  31 '1')
		(DW_LANG_Dylan  32 '0')
		(DW_LANG_C_plus_plus_14  33 '0')
		(DW_LANG_Fortran03  34 '1')
		(DW_LANG_Fortran08  35 '1')
		(DW_LANG_RenderScript  36 '0')
		(DW_LANG_BLISS  37 '0')
		(DW_LANG_lo_user 32768 '')
		(DW_LANG_hi_user 15 '')
		
		(DW_ID_case_sensitive 0)
		(DW_ID_up_case 1)
		(DW_ID_down_case 2)
		(DW_ID_case_insensitive 3)
		
		(DW_CC_normal 1)
		(DW_CC_program 2)
		(DW_CC_nocall 3)
		(DW_CC_pass_by_reference  4)
		(DW_CC_pass_by_value  5)
		(DW_CC_lo_user 64)
		
		(DW_INL_not_inlined 0)
		(DW_INL_inlined 1)
		(DW_INL_declared_not_inlined 2)
		(DW_INL_declared_inlined 3)
		
		(DW_ORD_row_major 0)
		(DW_ORD_col_major 1)
		
		(DW_DSC_label 0)
		(DW_DSC_range 1)
		
		(DW_IDX_compile_unit  1 'constant')
		(DW_IDX_type_unit  2 'constant')
		(DW_IDX_die_offset  3 'reference')
		(DW_IDX_parent  4 'constant')
		(DW_IDX_type_hash  5 'DW_FORM_data8')
		(DW_IDX_lo_user  8192 '')
		(DW_IDX_hi_user  63 '')
		
		(DW_DEFAULTED_no  0)
		(DW_DEFAULTED_in_class  1)
		(DW_DEFAULTED_out_of_class  2)
		
		(DW_LNS_copy 1)
		(DW_LNS_advance_pc 2)
		(DW_LNS_advance_line 3)
		(DW_LNS_set_file 4)
		(DW_LNS_set_column 5)
		(DW_LNS_negate_stmt 6)
		(DW_LNS_set_basic_block 7)
		(DW_LNS_const_add_pc 8)
		(DW_LNS_fixed_advance_pc 9)
		(DW_LNS_set_prologue_end 10)
		(DW_LNS_set_epilogue_begin 11)
		(DW_LNS_set_isa 12)

		(DW_LNE_end_sequence 1)
		(DW_LNE_set_address 2)
		(DW_LNE_set_discriminator 4)
		(DW_LNE_lo_user 128)
		(DW_LNE_hi_user 15)
		
		(DW_LNCT_path  1)
		(DW_LNCT_directory_index  2)
		(DW_LNCT_timestamp  3)
		(DW_LNCT_size  4)
		(DW_LNCT_MD5  5)
		(DW_LNCT_lo_user  8192)
		(DW_LNCT_hi_user  63)
		
		(DW_MACRO_define 1)
		(DW_MACRO_undef  2)
		(DW_MACRO_start_file  3)
		(DW_MACRO_end_file  4)
		(DW_MACRO_define_strp  5)
		(DW_MACRO_undef_strp  6)
		(DW_MACRO_import  7)
		(DW_MACRO_define_sup  8)
		(DW_MACRO_undef_sup  9)
		(DW_MACRO_import_sup  10)
		(DW_MACRO_define_strx  11)
		(DW_MACRO_undef_strx  12)
		(DW_MACRO_lo_user  224)
		(DW_MACRO_hi_user  15)
		
		(DW_RLE_end_of_list  0)
		(DW_RLE_base_addressx  1)
		(DW_RLE_startx_endx  2)
		(DW_RLE_startx_length  3)
		(DW_RLE_offset_pair  4)
		(DW_RLE_base_address  5)
		(DW_RLE_start_end  6)
		(DW_RLE_start_length  7)
	)
]

{ #category : #initialization }
SAsmDWConstants class >> initialize [
	| descriptions constantName constantValue |
	descriptions := self dwarfConstantsDescription.
	descriptions do: [ :desc |
		constantName := desc first.
		constantValue := desc second.
		
		(self hasClassVarNamed: constantName) ifFalse: [
			self addClassVarNamed: constantName
		].
	
		self classVarNamed: constantName put: (SAsmDWConstant new name: constantName; value: constantValue)
	]
]
