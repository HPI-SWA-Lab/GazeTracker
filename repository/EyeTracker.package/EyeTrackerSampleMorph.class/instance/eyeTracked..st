*EyeTracker
eyeTracked: evt
	
	evt isFixation ifFalse: [^ self].
	
	evt isFixationDelta
		ifTrue: [
			fixationPoints ifEmpty: [
				fixationPoints add: evt fixationPoint - self topLeft].
			positions add: evt position - self topLeft.]
		ifFalse: [
			fixationPoints add: evt position - self topLeft].
		
	self updateForm.