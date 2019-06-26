#pragma once

#include "Engine.h"

extern one::Engine* one::Generate();

#ifdef ON_WINDOW

int main(int argc, char** argv)
{
    auto game = one::Generate();
    game->Run();
    delete game;
}

#endif // ON_WINDOW
