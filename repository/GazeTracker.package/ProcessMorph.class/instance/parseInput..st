as yet unclassified
parseInput: aString
	| integers position |
	integers := (aString findTokens: ';') collect: [:a | a asInteger ].
	integers size = 2
		ifTrue: [
			position := (integers first) @ (integers second).
			"position := (640 - position x)@(position y)."
			^position ]
		ifFalse: [ ^0@0 ].