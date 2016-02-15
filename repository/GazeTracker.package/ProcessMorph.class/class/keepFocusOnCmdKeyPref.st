as yet unclassified
keepFocusOnCmdKeyPref
	<preference: 'Keep focus if command-key pressed'
		category: 'EyeTracking'
		description: ''
		type: #Boolean>
	^ KeepFocusOnCmdKeyPref ifNil: [KeepFocusOnCmdKeyPref := true]