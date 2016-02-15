accessing
initialize
	super initialize.
	self target: self.
	self actionSelector: #onClick.
	self label: 'Spawn input-test-window'.