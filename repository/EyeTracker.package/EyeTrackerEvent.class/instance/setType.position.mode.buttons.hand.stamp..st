private
setType: evtType position: evtPos mode: modeFlag buttons: evtButtons hand: evtHand stamp: stamp
	type := evtType.
	position := evtPos.
	buttons := evtButtons.
	source := evtHand.
	wasHandled := false.
	mode := modeFlag.
	timeStamp := stamp.