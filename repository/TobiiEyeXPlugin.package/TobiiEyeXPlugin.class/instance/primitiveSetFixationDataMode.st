primitives
primitiveSetFixationDataMode
	<export: true>
	| fixationDataMode result |
	interpreterProxy methodArgumentCount = 1
		ifFalse: [^ interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	fixationDataMode := interpreterProxy stackIntegerValue: 0.

	result := self eyeSetFixationDataMode: fixationDataMode.

	interpreterProxy pop: 1+1.
	interpreterProxy pushInteger: result.