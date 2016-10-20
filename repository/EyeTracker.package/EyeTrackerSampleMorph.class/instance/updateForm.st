drawing
updateForm

	| canvas |
	form := Form extent: self extent depth: 32.
	canvas := form getCanvas.
	canvas fillColor: Color white.
	canvas line: self leftCenter - self topLeft to: self rightCenter - self topLeft width: 1 color: Color lightGray.
	canvas line: self topCenter - self topLeft to: self bottomCenter - self topLeft width: 1 color: Color lightGray.
	positions do: [:pos | 
		canvas fillOval: (Rectangle center: pos extent: 5) color: Color blue muchLighter].
	fixationPointsSlow do: [:pos |
		canvas fillOval: (Rectangle center: pos extent: 12) color: Color red borderWidth: 1 borderColor: Color white.].
	fixationPointsSensitive do: [:pos |
		canvas fillOval: (Rectangle center: pos extent: 10) color: Color red borderWidth: 1 borderColor: Color white.].

	self changed