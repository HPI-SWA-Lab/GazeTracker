preferences
bringFocusedWindowToFront
	<preference: 'Bring focused windows to front'
		category: 'Gaze Tracker'
		description: 'When focussing a text field or another component, the surrounding system window will be brought to front, if there is one.'
		type: #Boolean>
	^ BringFocusedWindowToFrontPref ifNil: [BringFocusedWindowToFrontPref := true]