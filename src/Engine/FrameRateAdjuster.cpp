#include "FrameRateAdjuster.h"
#include "GameEngine.h"
#include "Process.h"
#include <iostream>
#include "System.h"

namespace xihad { namespace ngn
{

	FrameRateAdjuster::FrameRateAdjuster( float supposedUpdateInterval, float debugThreshold) :
		minInterval(supposedUpdateInterval), debugThreshold(debugThreshold)
	{
		setDebugName("FrameRateAdjuster");
	}

	void FrameRateAdjuster::onFrameBegin( GameEngine* source, float nowSecs )
	{
		bgnSecs = nowSecs;
	}

	void FrameRateAdjuster::onFrameEnd( GameEngine* source, float nowSecs, float delta )
	{
		if (bgnSecs + delta - nowSecs > 0.1f)
			std::cout << "FrameRateAdjuster find not-matching delta" << std::endl;

		delta = (float) (System::getCurrentTime() - bgnSecs);
		if (delta < minInterval)
		{
			Process::sleep(minInterval-delta);
			delta = minInterval;
		}
		else if (delta >= debugThreshold)
		{	// in here only when debugThreshold > minInterval
			delta = minInterval;
		}

		source->setFrameTime(delta);
	}

}}

