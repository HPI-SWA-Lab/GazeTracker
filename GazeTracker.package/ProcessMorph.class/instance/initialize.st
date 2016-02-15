as yet unclassified
initialize
	super initialize.
	self target: self.
	self actionSelector: #onClick.
	eyePostionMorph := CrossMorph new openInWorld.
	oldPositions := OrderedCollection new.
	smoothingPositions := OrderedCollection new.
	self label: 'Start/stop process'.
	"self initializeCalibrationMorphs."
"	self initializePathMorph."