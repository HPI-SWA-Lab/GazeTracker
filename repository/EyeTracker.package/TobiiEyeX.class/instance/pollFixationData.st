as yet unclassified
pollFixationData
	| fixationDataTransfer result |
	fixationDataTransfer := (Array new: 7).
	result := self primGetFixationData: fixationDataTransfer.
	self flag: #todo. "handle result error codes"
	^ fixationDataTransfer