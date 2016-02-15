as yet unclassified
baseline: spec 
	<baseline>
	spec
		for: #common
		do: [
			spec
				package: 'GazeTracker-Core' with: [
					spec
						repository: 'github://HPI-SWA-Lab/GazeTracker:master/repository'];	
									
				package: 'GazeTracker-Evaluation' with: [
					spec
						repository: 'github://HPI-SWA-Lab/GazeTracker:master/repository';
						requires: #('GazeTracker-Core' )].
					
			spec
				group: 'default' with: #('GazeTracker-Core' );
				group: 'evaluation' with: #('GazeTracker-Core' 'GazeTracker-Evaluation' )]