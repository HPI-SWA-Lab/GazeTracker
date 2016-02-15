preferences
eyeFocusViaHandler
	<preference: 'Eye focus if morph has eye-handler'
		category: 'EyeTracking'
		description: ''
		type: #Boolean>
	^ EyeFocusViaHandlerPref ifNil: [EyeFocusViaHandlerPref := true]