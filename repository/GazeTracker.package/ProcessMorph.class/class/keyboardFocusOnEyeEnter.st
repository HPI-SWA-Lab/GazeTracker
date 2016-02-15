preferences
keyboardFocusOnEyeEnter
	<preference: 'Force focus for keyboard-focus-handling morphs'
		category: 'EyeTracking'
		description: ''
		type: #Boolean>
	^KeyboardFocusOnEyeEnterPref ifNil: [KeyboardFocusOnEyeEnterPref := true]