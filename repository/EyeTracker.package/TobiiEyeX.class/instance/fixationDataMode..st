configuration
fixationDataMode: anInteger

	| result |
	(anInteger between: FixationDataModeSensitive and: FixationDataModeSlow)
		ifFalse: [self error: 'Wrong input: ' , anInteger].
	
	result := self primSetFixationDataMode: anInteger.
	result > 0 ifTrue: [self error: 'Setting fixation data mode to ' , anInteger , ' failed with code: ' , result].