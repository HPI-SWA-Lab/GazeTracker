initialization
initialize

	super initialize.
	positions := OrderedCollection new: 1024.
	fixationPoints := OrderedCollection new: 1024.
	self extent: 200@200.
	self updateForm.