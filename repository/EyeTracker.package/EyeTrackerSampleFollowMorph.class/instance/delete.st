submorphs-add/remove
delete

	| hand |
	super delete.
	hand := Project current world firstHand.
	hand removeEventCaptureFilter: self eventFilter.