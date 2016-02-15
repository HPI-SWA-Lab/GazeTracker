preferences
keyboardFocusOnEyeEnter
	<preference: 'Set Keyboard-focus if morph can handle it.'
		category: 'Gaze Tracker'
		description: 'Checks wether the morph at the current gaze-position wants keyboard-focus or can handle keyboard-events. If so, sets the keyboard-focus to this morph.'
		type: #Boolean>
	^KeyboardFocusOnEyeEnterPref ifNil: [KeyboardFocusOnEyeEnterPref := true]