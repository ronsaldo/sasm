Class {
	#name : #SAsmTacOperations,
	#superclass : #SharedPool,
	#classVars : [
		'TacAdd',
		'TacDivide',
		'TacEqual',
		'TacGreater',
		'TacGreaterOrEqual',
		'TacLess',
		'TacLessOrEqual',
		'TacLoad',
		'TacLoadDouble',
		'TacLoadFloat',
		'TacLoadSignExtend16',
		'TacLoadSignExtend32',
		'TacLoadSignExtend8',
		'TacLoadZeroExtend16',
		'TacLoadZeroExtend32',
		'TacLoadZeroExtend8',
		'TacMove',
		'TacMultiply',
		'TacNotEqual',
		'TacRemainder',
		'TacReturn',
		'TacStore',
		'TacStoreDouble',
		'TacStoreFloat',
		'TacStoreTruncate16',
		'TacStoreTruncate32',
		'TacStoreTruncate8',
		'TacSubtract',
		'TacUDivide',
		'TacURemainder'
	],
	#category : #'SAsm-Core-TAC'
}

{ #category : #'class initialization' }
SAsmTacOperations class >> initialize [
	super initialize.
	
	TacAdd := SAsmTacOperationAdd new.
	TacSubtract := SAsmTacOperationSubtract new.
	TacMultiply := SAsmTacOperationMultiply new.
	TacDivide := SAsmTacOperationDivide new.
	TacUDivide := SAsmTacOperationUDivide new.
	TacRemainder := SAsmTacOperationRemainder new.
	TacURemainder := SAsmTacOperationURemainder new.
	
	TacMove := SAsmTacMoveOperation new.
	TacReturn := SAsmTacReturnOperation new.

	TacEqual := SAsmTacComparisonOperationEqual new.
	TacNotEqual := SAsmTacComparisonOperationNotEqual new.
	TacGreater := SAsmTacComparisonOperationGreater new.
	TacGreaterOrEqual := SAsmTacComparisonOperationGreaterOrEqual new.	
	TacLess := SAsmTacComparisonOperationLess new.
	TacLessOrEqual := SAsmTacComparisonOperationLessOrEqual new.
	
	TacLoad := SAsmTacLoadOperation new.
	TacLoadFloat := SAsmTacLoadFloatOperation new.
	TacLoadDouble := SAsmTacLoadDoubleOperation new.
	TacLoadZeroExtend8 := SAsmTacLoadZeroExtend8Operation new.
	TacLoadZeroExtend16 := SAsmTacLoadZeroExtend16Operation new.
	TacLoadZeroExtend32 := SAsmTacLoadZeroExtend32Operation new.
	TacLoadSignExtend8 := SAsmTacLoadSignExtend8Operation new.
	TacLoadSignExtend16 := SAsmTacLoadSignExtend16Operation new.
	TacLoadSignExtend32 := SAsmTacLoadSignExtend32Operation new.
	
	TacStore := SAsmTacStoreOperation new.
	TacStoreFloat := SAsmTacStoreFloatOperation new.
	TacStoreDouble := SAsmTacStoreDoubleOperation new.
	TacStoreTruncate8 := SAsmTacStoreTruncate8Operation new.
	TacStoreTruncate16 := SAsmTacStoreTruncate16Operation new.
	TacStoreTruncate32 := SAsmTacStoreTruncate32Operation new.
]
