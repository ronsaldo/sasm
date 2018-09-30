Class {
	#name : #BaselineOfSAsm,
	#superclass : #BaselineOf,
	#category : #BaselineOfSAsm
}

{ #category : #baselines }
BaselineOfSAsm >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec 
			package: 'SAsm-Core';
			package: 'SAsm-DWARF' with: [
				spec requires: #('SAsm-Core' ). ];
			package: 'SAsm-Samples' with: [
				spec requires: #('SAsm-Core' ). ];
			package: 'SAsm-Tests' with: [
				spec requires: #('SAsm-Core' ). ]. ].

]
