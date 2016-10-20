initialization
initialize

	super initialize.
	positions := OrderedCollection new: 1024.
	fixationPointsSlow := OrderedCollection new: 1024.
	fixationPointsSensitive := OrderedCollection new: 1024.
	self extent: 200@200.
	self updateForm.