as yet unclassified
pollFixationData
	| fixationDataTransfer result |
	fixationDataTransfer := (Array new: 7).
	result := self primGetFixationData: fixationDataTransfer.
	
	self flag: #todo. "handle result error codes"
	result ifNil: [^ fixationDataTransfer].
	result = GazeNotTracked ifTrue: [^ fixationDataTransfer].
	result = PrimErrBadArgument ifTrue: ["TODO"].
	result = PrimErrBadNumArgs ifTrue: ["TODO"].
	
	result > 0 ifTrue: [
		Transcript showln: 'EyeTracker error code: ' , result].
	
	^ fixationDataTransfer