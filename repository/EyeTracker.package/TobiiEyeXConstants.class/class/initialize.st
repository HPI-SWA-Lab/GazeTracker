pool initialization
initialize
	"TobiiEyeXConstants initialize"
	FixationDataEventTypeBegin := 1.
	FixationDataEventTypeEnd := 2.
	FixationDataEventTypeData := 3.
	
	FixationDataModeSensitive := 1.
	FixationDataModeSlow := 2.
	
	GazeNotTracked := 1.
	
	"VMBasicConstants"
	PrimErrBadArgument := 3.
	PrimErrBadNumArgs := 5.
	
	"Need to recompile some methods to have the right literal bindings from pool variables defined above"
	HandMorph compileAll.