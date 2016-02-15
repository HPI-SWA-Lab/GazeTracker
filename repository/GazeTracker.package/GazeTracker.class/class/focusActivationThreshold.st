preferences
focusActivationThreshold
	<preference: 'Focus activation threshold (ms)'
		category: 'Gaze Tracker'
		description: 'The time in milliseconds a morph needs to be gazed at continiously before it gets keyboard focus. Avoids focus-flickering.'
		type: #Number>
	^FocusActivationThreshold ifNil: [FocusActivationThreshold := 250]