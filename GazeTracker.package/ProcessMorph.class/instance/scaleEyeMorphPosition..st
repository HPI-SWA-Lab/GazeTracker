as yet unclassified
scaleEyeMorphPosition: aPosition
	| cameraWidth cameraHeight scaleFactor position |
	"cameraWidth := 640.
	cameraHeight := 480."
	cameraWidth := (bottomRightPosition - topLeftPosition) x.
	cameraHeight := (bottomRightPosition - topLeftPosition) y.
	position := aPosition - topLeftPosition.
	scaleFactor := 1.
	position := ((position x - (cameraWidth / 2)) * scaleFactor + (cameraWidth / 2))@((position y - (cameraHeight / 2)) * scaleFactor + (cameraHeight / 2)).
	position := (World extent x * position x / cameraWidth)@(World extent y * position y / cameraHeight).
	^ position