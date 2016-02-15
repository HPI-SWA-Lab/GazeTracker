as yet unclassified
registerInWorldMenu
	self environment at: #TheWorldMenu ifPresent: [ :class |
		class registerOpenCommand: (Array 
			with: 'GazeTracker' 
			with: (Array
				with: self
				with: #open)) ].