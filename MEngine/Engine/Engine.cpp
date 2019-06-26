#include "PCH.h"
#include "Engine.h"

namespace one
{
	Engine::Engine()
		:m_Running(true)
	{
	}

	Engine::~Engine()
	{
	}

	void Engine::Run()
	{
		while (m_Running)
		{
			std::cout << "Running" << std::endl;
		}
	}
}