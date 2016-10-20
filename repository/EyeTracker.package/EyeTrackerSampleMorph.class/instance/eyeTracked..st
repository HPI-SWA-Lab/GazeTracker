*EyeTracker
eyeTracked: evt
	
	| fixationPoints |
	evt isFixation ifFalse: [^ self].
	fixationPoints := evt mode = #sensitive
		ifTrue: [fixationPointsSensitive]
		ifFalse: [fixationPointsSlow].
	evt isFixationDelta
		ifTrue: [
			fixationPoints ifEmpty: [
				fixationPoints add: evt fixationPoint - self topLeft].
			positions add: evt position - self topLeft.]
		ifFalse: [
			fixationPoints add: evt position - self topLeft].
		
	self updateForm.