preferences
eyeTrackerFixationDataModeSensitive: aBoolean

	EyeTrackerFixationDataModeSensitive := aBoolean.
	
	aBoolean
		ifTrue: [self engine beFixationDataModeSensitive]
		ifFalse: [self engine beFixationDataModeSlow]