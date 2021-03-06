Class {
	#name : #'SAsmX86_64CallingConventionNaked',
	#superclass : #'SAsmX86_64CallingConvention',
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86_64CallingConventionNaked >> isNaked [
	^ true
]

{ #category : #accessing }
SAsmX86_64CallingConventionNaked >> name [
	^ #naked
]

{ #category : #stack }
SAsmX86_64CallingConventionNaked >> stackAlignment [
	^ 1
]
