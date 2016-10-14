*EyeTracker
eyeTracked: event
	self eventHandler ifNotNil:
		[self eventHandler eyeTracked: event fromMorph: self].