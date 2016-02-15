preferences
eyeFocusViaHandler
	<preference: 'Use eye-handler'
		category: 'Gaze Tracker'
		description: 'Checks if the morph at the current gaze-position has an eye handler registered (a block). Calls the handler, if there is one. (morph hasProperty: #eyeFocusHandler)'
		type: #Boolean>
	^ EyeFocusViaHandlerPref ifNil: [EyeFocusViaHandlerPref := true]