initialize-release
shutdownModule
	<export: true>
	^self cCode: 'eyeShutdown()' inSmalltalk:[true]