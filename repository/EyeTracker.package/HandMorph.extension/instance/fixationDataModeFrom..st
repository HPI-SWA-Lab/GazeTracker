*EyeTracker
fixationDataModeFrom: anInteger

	^ anInteger
		caseOf: {
			[FixationDataModeSensitive]->[#sensitive].
			[FixationDataModeSlow]->[#slow]}
		otherwise: []