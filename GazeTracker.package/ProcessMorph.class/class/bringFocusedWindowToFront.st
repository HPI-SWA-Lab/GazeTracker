as yet unclassified
bringFocusedWindowToFront
	<preference: 'Bring focused windows to front'
		category: 'EyeTracking'
		description: ''
		type: #Boolean>
	^ BringFocusedWindowToFrontPref ifNil: [BringFocusedWindowToFrontPref := true]