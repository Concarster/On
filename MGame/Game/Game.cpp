#include "Game.h"
#include "Engine/Main.h"

Game::Game()
{
}

Game::~Game()
{
}

one::Engine* one::Generate()
{
	return new Game();
}
