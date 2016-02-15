as yet unclassified
initializeCalibrationMorphs
	|buttonExtent|
	buttonExtent := 100@20.
	topLeftMorph := SimpleButtonMorph new position: 0@0; extent: buttonExtent; openInWorld.
	bottomRightMorph := SimpleButtonMorph new position: (ActiveWorld extent - buttonExtent); extent: buttonExtent; openInWorld.
	topLeftMorph target: self; actionSelector: #calibrateTopLeft.
	bottomRightMorph target: self; actionSelector: #calibrateBottomRight.
	topLeftPosition := 0@0.
	bottomRightPosition := 640@480.
	