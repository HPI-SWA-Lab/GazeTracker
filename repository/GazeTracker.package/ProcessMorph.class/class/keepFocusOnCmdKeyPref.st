preferences
keepFocusOnCmdKeyPref
	<preference: 'Keep focus if command-key pressed'
		category: 'Gaze Tracker'
		description: 'Does no change focus, if command-key is pressed.'
		type: #Boolean>
	^ KeepFocusOnCmdKeyPref ifNil: [KeepFocusOnCmdKeyPref := true]