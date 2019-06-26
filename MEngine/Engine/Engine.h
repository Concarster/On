#pragma once

namespace one
{
	class Engine
	{
	private:
		bool m_Running;

	public:
		Engine();
		~Engine();

		void Run();
	};

	/*Clients */
	Engine* Generate();
}
