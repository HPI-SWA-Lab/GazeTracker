/****************************************************************************
 *   PROJECT: Tobii EyeX - Eye Tracker (for Windows)
 *   FILE:    eyeWin32Tobii.c
 *   CONTENT: Talks to the Tobii EyeX Engine
 *
 *   AUTHORS:  Marcel Taeumel (mt)
 *               Hasso Plattner Institute, Postdam, Germany
 *
 *   Permission is hereby granted, free of charge, to any person obtaining a copy
 *   of this software and associated documentation files (the "Software"), to deal
 *   in the Software without restriction, including without limitation the rights
 *   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *   copies of the Software, and to permit persons to whom the Software is
 *   furnished to do so, subject to the following conditions:
 * 
 *   The above copyright notice and this permission notice shall be included in
 *   all copies or substantial portions of the Software.
 * 
 *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *   SOFTWARE.
*****************************************************************************/

#include <windows.h>
#include <errno.h>
#include <malloc.h>
#include <stdio.h>
#include <conio.h>
#include <assert.h>

#include "sq.h"
#include "TobiiEyeX.h"
#include "eyex/EyeX.h"

#pragma comment (lib, "Tobii.EyeX.Client.lib")

// ID of the global interactor that provides our data stream; must be unique within the application.
static const TX_STRING InteractorId = "Squeak";

// global variables
static TX_HANDLE g_hGlobalInteractorSnapshot = TX_EMPTY_HANDLE;
static TX_CONTEXTHANDLE g_hContext = TX_EMPTY_HANDLE;
static TX_HANDLE g_hFixInteractor = TX_EMPTY_HANDLE;
static TX_HANDLE g_hFixBehavior = TX_EMPTY_HANDLE;
static TX_GAZETRACKING g_gazeTrackedStatus;
static TX_FIXATIONDATAEVENTPARAMS g_fixationDataBeginEventParams;
static TX_FIXATIONDATAEVENTPARAMS g_fixationDataEventParams;
static TX_GAZEPOINTDATAEVENTPARAMS g_gazeDataEventParams;
static CRITICAL_SECTION CriticalSectionFixation;
static CRITICAL_SECTION CriticalSectionGaze;

/*
 * Initializes g_hGlobalInteractorSnapshot with an interactor that has the Gaze Point behavior.
 */
BOOL InitializeGlobalInteractorSnapshot(TX_CONTEXTHANDLE hContext)
{
	//TX_GAZEPOINTDATAPARAMS params = { TX_GAZEPOINTDATAMODE_LIGHTLYFILTERED };
	//TX_FIXATIONDATAPARAMS fixParams = { TX_FIXATIONDATAMODE_SENSITIVE };
	TX_FIXATIONDATAPARAMS fixParams = { TX_FIXATIONDATAMODE_SLOW };
	BOOL success;

	success = txCreateGlobalInteractorSnapshot(
		hContext,
		InteractorId,
		&g_hGlobalInteractorSnapshot,
		&g_hFixInteractor) == TX_RESULT_OK;
	success &= txCreateInteractorBehavior(g_hFixInteractor, &g_hFixBehavior, TX_BEHAVIORTYPE_FIXATIONDATA) == TX_RESULT_OK;
	success &= txSetFixationDataBehaviorParams(g_hFixBehavior, &fixParams) == TX_RESULT_OK;

	return success;
}

/*
 * Callback function invoked when a snapshot has been committed.
 */
void TX_CALLCONVENTION OnSnapshotCommitted(TX_CONSTHANDLE hAsyncData, TX_USERPARAM param)
{
	// check the result code using an assertion.
	// this will catch validation errors and runtime errors in debug builds. in release builds it won't do anything.

	TX_RESULT result = TX_RESULT_UNKNOWN;
	txGetAsyncDataResultCode(hAsyncData, &result);
	assert(result == TX_RESULT_OK || result == TX_RESULT_CANCELLED);
}

/*
 * Handles a state-changed notification, or the response from a get-state operation.
 */
void OnStateReceived(TX_HANDLE hStateBag)
{
	TX_BOOL success;
	TX_INTEGER gazeTracking;

    // The following state requires EyeX Engine 1.4.0 or later:
	success = (txGetStateValueAsInteger(hStateBag, TX_STATEPATH_GAZETRACKING, &gazeTracking) == TX_RESULT_OK);
	if (success) {
		EnterCriticalSection(&CriticalSectionFixation);
		g_gazeTrackedStatus = gazeTracking;
		LeaveCriticalSection(&CriticalSectionFixation);
		
		printf("User's eye-gaze is %s\n", gazeTracking == TX_GAZETRACKING_GAZETRACKED ? "tracked" : "NOT tracked");
	}
}

/*
 * Handles engine state change notifications.
 */
void TX_CALLCONVENTION OnEngineStateChanged(TX_CONSTHANDLE hAsyncData, TX_USERPARAM userParam)
{
	TX_RESULT result = TX_RESULT_UNKNOWN;
	TX_HANDLE hStateBag = TX_EMPTY_HANDLE;

	if (txGetAsyncDataResultCode(hAsyncData, &result) == TX_RESULT_OK && 
		txGetAsyncDataContent(hAsyncData, &hStateBag) == TX_RESULT_OK) {
		OnStateReceived(hStateBag);
		txReleaseObject(&hStateBag);
	}
}

/*
 * Callback function invoked when the status of the connection to the EyeX Engine has changed.
 */
void TX_CALLCONVENTION OnEngineConnectionStateChanged(TX_CONNECTIONSTATE connectionState, TX_USERPARAM userParam)
{
	switch (connectionState) {
	case TX_CONNECTIONSTATE_CONNECTED: {
			BOOL success;
			printf("The connection state is now CONNECTED (We are connected to the EyeX Engine)\n");
			// commit the snapshot with the global interactor as soon as the connection to the engine is established.
			// (it cannot be done earlier because committing means "send to the engine".)
			success = txCommitSnapshotAsync(g_hGlobalInteractorSnapshot, OnSnapshotCommitted, NULL) == TX_RESULT_OK;
			if (!success) {
				printf("Failed to initialize the data stream.\n");
			}
			else {
				printf("Waiting for gaze data to start streaming...\n");
			}

			txGetStateAsync(g_hContext, TX_STATEPATH_EYETRACKING, OnEngineStateChanged, NULL);
		}
		break;

	case TX_CONNECTIONSTATE_DISCONNECTED:
		printf("The connection state is now DISCONNECTED (We are disconnected from the EyeX Engine)\n");
		break;

	case TX_CONNECTIONSTATE_TRYINGTOCONNECT:
		printf("The connection state is now TRYINGTOCONNECT (We are trying to connect to the EyeX Engine)\n");
		break;

	case TX_CONNECTIONSTATE_SERVERVERSIONTOOLOW:
		printf("The connection state is now SERVER_VERSION_TOO_LOW: this application requires a more recent version of the EyeX Engine to run.\n");
		break;

	case TX_CONNECTIONSTATE_SERVERVERSIONTOOHIGH:
		printf("The connection state is now SERVER_VERSION_TOO_HIGH: this application requires an older version of the EyeX Engine to run.\n");
		break;
	}
}

/*
 * Handles an event from the Gaze Point data stream.
 */
void OnGazeDataEvent(TX_HANDLE hGazeDataBehavior)
{
	TX_GAZEPOINTDATAEVENTPARAMS eventParams;
	if (txGetGazePointDataEventParams(hGazeDataBehavior, &eventParams) == TX_RESULT_OK) {
			printf("Gaze Data: (%.1f, %.1f) timestamp %.0f ms\n", eventParams.X, eventParams.Y, eventParams.Timestamp);
			EnterCriticalSection(&CriticalSectionGaze);
			g_gazeDataEventParams = eventParams;
			LeaveCriticalSection(&CriticalSectionGaze);
		//}
	} else {
		//printf("Failed to interpret gaze data event packet.\n");
	}
}

/*
* Handles an event from the Fixation Point data stream.
*/
void OnFixationDataEvent(TX_HANDLE hFixDataBehavior)
{
	TX_FIXATIONDATAEVENTPARAMS eventParams;
	if (txGetFixationDataEventParams(hFixDataBehavior, &eventParams) == TX_RESULT_OK) {
		EnterCriticalSection(&CriticalSectionFixation);
		if (eventParams.EventType == TX_FIXATIONDATAEVENTTYPE_BEGIN) {
			printf("Fix  Data Begin: (%.1f, %.1f) timestamp %.0f ms\n", eventParams.X, eventParams.Y, eventParams.Timestamp);
			g_fixationDataBeginEventParams = eventParams;
			g_fixationDataEventParams = eventParams;
		} else if (eventParams.EventType == TX_FIXATIONDATAEVENTTYPE_DATA) {
			g_fixationDataEventParams = eventParams;
			//printf("Fix  Data: (%.1f, %.1f) timestamp %.0f ms\n", eventParams.X, eventParams.Y, eventParams.Timestamp);
		}
		LeaveCriticalSection(&CriticalSectionFixation);
	}
	else {
		printf("Failed to interpret fix data event packet.\n");
	}
}

/*
 * Callback function invoked when an event has been received from the EyeX Engine.
 */
void TX_CALLCONVENTION HandleEvent(TX_CONSTHANDLE hAsyncData, TX_USERPARAM userParam)
{
	TX_HANDLE hEvent = TX_EMPTY_HANDLE;
	TX_HANDLE hBehavior = TX_EMPTY_HANDLE;

	txGetAsyncDataContent(hAsyncData, &hEvent);

	// NOTE. Uncomment the following line of code to view the event object. The same function can be used with any interaction object.
	//OutputDebugStringA(txDebugObject(hEvent));

	if (txGetEventBehavior(hEvent, &hBehavior, TX_BEHAVIORTYPE_GAZEPOINTDATA) == TX_RESULT_OK) {
		OnGazeDataEvent(hBehavior);
		txReleaseObject(&hBehavior);
	}

	if (txGetEventBehavior(hEvent, &hBehavior, TX_BEHAVIORTYPE_FIXATIONDATA) == TX_RESULT_OK) {
		OnFixationDataEvent(hBehavior);
		txReleaseObject(&hBehavior);
	}

	// NOTE since this is a very simple application with a single interactor and a single data stream, 
	// our event handling code can be very simple too. A more complex application would typically have to 
	// check for multiple behaviors and route events based on interactor IDs.

	txReleaseObject(&hEvent);
}

/********************************************************************************************************
*
* Squeak VM primitives
*
*********************************************************************************************************/

sqInt eyeInit(void) {
	TX_TICKET hConnectionStateChangedTicket = TX_INVALID_TICKET;
	TX_TICKET hEventHandlerTicket = TX_INVALID_TICKET;
	TX_TICKET hGazeTrackingStateChangedTicket = TX_INVALID_TICKET;
	BOOL success;

	InitializeCriticalSection(&CriticalSectionFixation);
	InitializeCriticalSection(&CriticalSectionGaze);

	// initialize and enable the context that is our link to the EyeX Engine.
	success = txInitializeEyeX(TX_EYEXCOMPONENTOVERRIDEFLAG_NONE, NULL, NULL, NULL, NULL) == TX_RESULT_OK;
	success &= txCreateContext(&g_hContext, TX_FALSE) == TX_RESULT_OK;
	success &= InitializeGlobalInteractorSnapshot(g_hContext);
	success &= txRegisterConnectionStateChangedHandler(g_hContext, &hConnectionStateChangedTicket, OnEngineConnectionStateChanged, NULL) == TX_RESULT_OK;
	success &= txRegisterStateChangedHandler(g_hContext, &hGazeTrackingStateChangedTicket, TX_STATEPATH_GAZETRACKING, OnEngineStateChanged, NULL) == TX_RESULT_OK;
	success &= txRegisterEventHandler(g_hContext, &hEventHandlerTicket, HandleEvent, NULL) == TX_RESULT_OK;
	success &= txEnableConnection(g_hContext) == TX_RESULT_OK;

	if (success) {
		printf("Initialization was successful.\n");
	} else {
		printf("Initialization failed.\n");
	}
	return success;
}

sqInt eyeShutdown(void) {
	BOOL success;

	DeleteCriticalSection(&CriticalSectionFixation);
	DeleteCriticalSection(&CriticalSectionGaze);

	// disable and delete the context.
	txDisableConnection(g_hContext);
	txReleaseObject(&g_hGlobalInteractorSnapshot);
	txReleaseObject(&g_hFixBehavior);
	txReleaseObject(&g_hFixInteractor);

	success = txShutdownContext(g_hContext, TX_CLEANUPTIMEOUT_DEFAULT, TX_FALSE) == TX_RESULT_OK;
	success &= txReleaseContext(&g_hContext) == TX_RESULT_OK;
	success &= txUninitializeEyeX() == TX_RESULT_OK;
	if (!success) {
		printf("EyeX could not be shut down cleanly. Did you remember to release all handles?\n");
	} else {
		printf("Shutdown successful\n");
	}

	return success;
}

int eyeGetFixationData(double* transferArray) {
	TX_FIXATIONDATAEVENTPARAMS fixationDataBeginEventParams;
	TX_FIXATIONDATAEVENTPARAMS fixationDataEventParams;
	TX_GAZETRACKING gazeTrackedStatus;

	EnterCriticalSection(&CriticalSectionFixation);
	fixationDataBeginEventParams = g_fixationDataBeginEventParams;
	fixationDataEventParams = g_fixationDataEventParams;
	gazeTrackedStatus = g_gazeTrackedStatus;
	LeaveCriticalSection(&CriticalSectionFixation);

	if (gazeTrackedStatus == TX_GAZETRACKING_GAZENOTTRACKED) {
		return EYE_GAZENOTTRACKED;
	}

	transferArray[0] = fixationDataBeginEventParams.FixationDataMode;
	transferArray[1] = fixationDataBeginEventParams.Timestamp;
	transferArray[2] = fixationDataBeginEventParams.X;
	transferArray[3] = fixationDataBeginEventParams.Y;

	transferArray[4] = fixationDataEventParams.Timestamp;
	transferArray[5] = fixationDataEventParams.X;
	transferArray[6] = fixationDataEventParams.Y;

	return EYE_GAZETRACKED;
}

int eyeSetFixationDataMode(int mode) {
	TX_FIXATIONDATAMODE txMode =
		mode == EYE_FIXATIONDATAMODE_SENSITIVE
			? TX_FIXATIONDATAMODE_SENSITIVE
			: TX_FIXATIONDATAMODE_SLOW;
	TX_FIXATIONDATAPARAMS fixParams = { txMode };
	BOOL success;

	txDisableConnection(g_hContext);
	success &= txSetFixationDataBehaviorParams(g_hFixBehavior, &fixParams) == TX_RESULT_OK;
	success &= txEnableConnection(g_hContext) == TX_RESULT_OK;

	return success;
}