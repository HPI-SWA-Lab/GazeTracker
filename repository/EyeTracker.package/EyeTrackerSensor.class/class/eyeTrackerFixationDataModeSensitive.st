preferences
eyeTrackerFixationDataModeSensitive
	<preference: 'eyeTrackerFixationDataModeSensitive'
		category: 'EyeTracker'
		description: 'If true (sensitive mode), the eye tracker provides more fixation points, but noise is possible. If false (slow mode), the eye tracker delivers less but stable fixation points.'
		type: #Boolean>
	^ EyeTrackerFixationDataModeSensitive ifNil: [false]