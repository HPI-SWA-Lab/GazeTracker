primitives
primitiveGetFixationData
	<export: true>
	<var: #fixationDataBuf declareC:'double fixationDataBuf[7] = { -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0}'>
	| fixationDataBuf fixationData result |
	self cCode: [] inSmalltalk: [fixationDataBuf := Array new: 7].
	interpreterProxy methodArgumentCount = 1
		ifFalse: [^ interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	fixationData := interpreterProxy stackObjectValue: 0.
	((interpreterProxy isArray: fixationData) and: [(interpreterProxy slotSizeOf: fixationData) = 7])
		ifFalse: [^ interpreterProxy primitiveFailFor: PrimErrBadArgument].

	result := self eyeGetFixationData: (self cCoerce: fixationDataBuf to: 'double*').
	interpreterProxy failed ifTrue:[^nil].
	0 to: 6 do: [:i |
		interpreterProxy storePointer: i ofObject: fixationData withValue: (interpreterProxy floatObjectOf: (fixationDataBuf at: i))].
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy pop: 1.
	interpreterProxy pushInteger: result.