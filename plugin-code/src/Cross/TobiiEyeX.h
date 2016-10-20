#ifndef TOBIIEYEX_H_
#define TOBIIEYEX_H_

/* Maybe we don't need the driver version ... */
#define TOBII_EYEX_DRIVER_VERSION_MAJOR 2
#define TOBII_EYEX_DRIVER_VERSION_MINOR 0
#define TOBII_EYEX_DRIVER_VERSION_BUILD 4

/* Engine abstracts from the driver. */
#define TOBII_EYEX_ENGINE_VERSION_MAJOR 1
#define TOBII_EYEX_ENGINE_VERSION_MINOR 9
#define TOBII_EYEX_ENGINE_VERSION_BUILD 0

#define TOBII_EYEX_PLUGIN_VERSION 1

typedef enum {
	EYE_GAZETRACKED = 0,
	EYE_GAZENOTTRACKED
} EYE_TRACKING_STATUS_CODES;

typedef enum {
	EYE_FIXATIONDATAMODE_SENSITIVE = 1,
	EYE_FIXATIONDATAMODE_SLOW
} EYE_FIXATION_DATA_MODE;

int eyeInit(void);
int eyeShutdown(void);

int eyeGetFixationData(double*);
int eyeSetFixationDataMode(int);

#endif