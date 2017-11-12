Class {
	#name : #SAsmTacOperations,
	#superclass : #SharedPool,
	#classVars : [
		'TacAbove',
		'TacAboveOrEqual',
		'TacAdd',
		'TacArithmeticShiftRight',
		'TacAtomicCompareAndSwap',
		'TacAtomicFetchAndAdd',
		'TacAtomicSwap',
		'TacBelow',
		'TacBelowOrEqual',
		'TacBitAnd',
		'TacBitNot',
		'TacBitOr',
		'TacBitXor',
		'TacContextReplaceFunction',
		'TacDivide',
		'TacDoubleToFloat',
		'TacDoubleToInt32',
		'TacDoubleToInt64',
		'TacDoubleToUInt32',
		'TacDoubleToUInt64',
		'TacEqual',
		'TacFloatAdd',
		'TacFloatDivide',
		'TacFloatMultiply',
		'TacFloatNegate',
		'TacFloatOrderedEqual',
		'TacFloatOrderedGreater',
		'TacFloatOrderedGreaterOrEqual',
		'TacFloatOrderedLess',
		'TacFloatOrderedLessOrEqual',
		'TacFloatOrderedNotEqual',
		'TacFloatSqrt',
		'TacFloatSubtract',
		'TacFloatToDouble',
		'TacFloatToInt32',
		'TacFloatToInt64',
		'TacFloatToUInt32',
		'TacFloatToUInt64',
		'TacFloatUnorderedEqual',
		'TacFloatUnorderedGreater',
		'TacFloatUnorderedGreaterOrEqual',
		'TacFloatUnorderedLess',
		'TacFloatUnorderedLessOrEqual',
		'TacFloatUnorderedNotEqual',
		'TacGreater',
		'TacGreaterOrEqual',
		'TacInt32ToDouble',
		'TacInt32ToFloat',
		'TacInt64ToDouble',
		'TacInt64ToFloat',
		'TacLess',
		'TacLessOrEqual',
		'TacLoad',
		'TacLoadDouble',
		'TacLoadFloat',
		'TacLoadLocalAddress',
		'TacLoadSignExtend16',
		'TacLoadSignExtend32',
		'TacLoadSignExtend8',
		'TacLoadZeroExtend16',
		'TacLoadZeroExtend32',
		'TacLoadZeroExtend8',
		'TacLogicalNot',
		'TacLogicalShiftLeft',
		'TacLogicalShiftRight',
		'TacMove',
		'TacMultiply',
		'TacNegate',
		'TacNotEqual',
		'TacReinterpretFloatAsInteger',
		'TacReinterpretIntegerAsFloat',
		'TacRemainder',
		'TacReturn',
		'TacRotateLeft',
		'TacRotateRight',
		'TacSignExtend16',
		'TacSignExtend32',
		'TacSignExtend8',
		'TacStore',
		'TacStoreDouble',
		'TacStoreFloat',
		'TacStoreTruncate16',
		'TacStoreTruncate32',
		'TacStoreTruncate8',
		'TacSubtract',
		'TacTruncate16',
		'TacTruncate32',
		'TacTruncate8',
		'TacUDivide',
		'TacUInt32ToDouble',
		'TacUInt32ToFloat',
		'TacUInt64ToDouble',
		'TacUInt64ToFloat',
		'TacURemainder',
		'TacZeroExtend16',
		'TacZeroExtend32',
		'TacZeroExtend8'
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
	TacNegate := SAsmTacOperationNegate new.
	
	TacBitAnd := SAsmTacBitAnd new.
	TacBitOr := SAsmTacBitOr new.
	TacBitXor := SAsmTacBitXor new.
	TacBitNot := SAsmTacBitNot new.
	TacLogicalNot := SAsmTacLogicalNot new.
	TacLogicalShiftLeft := SAsmTacLogicalShiftLeft new.
	TacLogicalShiftRight := SAsmTacLogicalShiftRight new.
	TacArithmeticShiftRight := SAsmTacArithmeticShiftRight new.
	TacRotateLeft := SAsmTacRotateLeft new.
	TacRotateRight := SAsmTacRotateRight new.
		
	TacMove := SAsmTacMoveOperation new.
	TacLoadLocalAddress := SAsmTacLoadLocalAddress new.
	TacReturn := SAsmTacReturnOperation new.

	TacEqual := SAsmTacComparisonIntegerEqual new.
	TacNotEqual := SAsmTacComparisonIntegerNotEqual new.
	TacGreater := SAsmTacComparisonIntegerGreater new.
	TacGreaterOrEqual := SAsmTacComparisonIntegerGreaterOrEqual new.	
	TacLess := SAsmTacComparisonIntegerLess new.
	TacLessOrEqual := SAsmTacComparisonIntegerLessOrEqual new.

	TacAbove := SAsmTacComparisonIntegerAbove new.
	TacAboveOrEqual := SAsmTacComparisonIntegerAboveOrEqual new.	
	TacBelow := SAsmTacComparisonIntegerBelow new.
	TacBelowOrEqual := SAsmTacComparisonIntegerBelowOrEqual new.

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
	
	TacSignExtend8 := SAsmTacSignExtend8Operation new.
	TacSignExtend16 := SAsmTacSignExtend16Operation new.
	TacSignExtend32 := SAsmTacSignExtend32Operation new.
	TacZeroExtend8 := SAsmTacZeroExtend8Operation new.
	TacZeroExtend16 := SAsmTacZeroExtend16Operation new.
	TacZeroExtend32 := SAsmTacZeroExtend32Operation new.
	TacTruncate8 := SAsmTacTruncate8Operation new.
	TacTruncate16 := SAsmTacTruncate16Operation new.
	TacTruncate32 := SAsmTacTruncate32Operation new.
	
	TacAtomicCompareAndSwap := SAsmTacAtomicCompareAndSwap new.
	TacAtomicFetchAndAdd := SAsmTacAtomicFetchAndAdd new.
	TacAtomicSwap := SAsmTacAtomicSwap new.
	
	TacContextReplaceFunction := SAsmTacContextReplaceFunctionOperation new.
	
	TacFloatAdd := SAsmTacOperationFloatAdd new.
	TacFloatSubtract := SAsmTacOperationFloatSubtract new.
	TacFloatDivide := SAsmTacOperationFloatDivide new.
	TacFloatNegate := SAsmTacOperationFloatNegate new.
	TacFloatMultiply := SAsmTacOperationFloatMultiply new.
	TacFloatSqrt := SAsmTacOperationFloatSqrt new.

	TacFloatOrderedEqual := SAsmTacComparisonFloatOrderedEqual new.
	TacFloatOrderedNotEqual := SAsmTacComparisonFloatOrderedNotEqual new.
	TacFloatOrderedLess := SAsmTacComparisonFloatOrderedLess new.
	TacFloatOrderedLessOrEqual := SAsmTacComparisonFloatOrderedLessOrEqual new.
	TacFloatOrderedGreaterOrEqual := SAsmTacComparisonFloatOrderedGreaterOrEqual new.
	TacFloatOrderedGreater := SAsmTacComparisonFloatOrderedGreater new.

	TacFloatUnorderedEqual := SAsmTacComparisonFloatUnorderedEqual new.
	TacFloatUnorderedNotEqual := SAsmTacComparisonFloatUnorderedNotEqual new.
	TacFloatUnorderedLess := SAsmTacComparisonFloatUnorderedLess new.
	TacFloatUnorderedLessOrEqual := SAsmTacComparisonFloatUnorderedLessOrEqual new.
	TacFloatUnorderedGreaterOrEqual := SAsmTacComparisonFloatUnorderedGreaterOrEqual new.
	TacFloatUnorderedGreater := SAsmTacComparisonFloatUnorderedGreater new.
	
	TacFloatToDouble := SAsmTacFloatToDoubleOperation new.
	TacDoubleToFloat := SAsmTacDoubleToFloatOperation new.
	
	TacInt32ToFloat := SAsmTacInt32ToFloatOperation new.
	TacInt32ToDouble := SAsmTacInt32ToDoubleOperation new.
	TacInt64ToFloat := SAsmTacInt64ToFloatOperation new.
	TacInt64ToDouble := SAsmTacInt64ToDoubleOperation new.
	TacUInt32ToFloat := SAsmTacUInt32ToFloatOperation new.
	TacUInt32ToDouble := SAsmTacUInt32ToDoubleOperation new.
	TacUInt64ToFloat := SAsmTacUInt64ToFloatOperation new.
	TacUInt64ToDouble := SAsmTacUInt64ToDoubleOperation new.
	
	TacFloatToInt32 := SAsmTacFloatToInt32Operation new.
	TacFloatToInt64 := SAsmTacFloatToInt64Operation new.
	TacFloatToUInt32 := SAsmTacFloatToUInt32Operation new.
	TacFloatToUInt64 := SAsmTacFloatToUInt64Operation new.

	TacDoubleToInt32 := SAsmTacDoubleToInt32Operation new.
	TacDoubleToInt64 := SAsmTacDoubleToInt64Operation new.
	TacDoubleToUInt32 := SAsmTacDoubleToUInt32Operation new.
	TacDoubleToUInt64 := SAsmTacDoubleToUInt64Operation new.
	
	TacReinterpretFloatAsInteger := SAsmTacReinterpretFloatAsInteger new.
	TacReinterpretIntegerAsFloat := SAsmTacReinterpretIntegerAsFloat new.
]
