workspace "On"

configurations { "Debug", "Release" }          -- Dropdown Solution Configurations

platforms { "x86", "x64" }                     -- Dropdown Solution Confg Platforms section in VS

startproject "MGame"

filter "system:windows"

disablewarnings { "4996", "4251" }
                  

outputdir = "%{cfg.buildcfg}_%{cfg.system}_%{cfg.architecture}"


IncludeDir = {}                                 -- Include directories relative to root folder (solution directory)

IncludeDir["GLFW"]     = "Mods/GLFW/include"
IncludeDir["Glad"]     = "Mods/Glad/include"
IncludeDir["ImGui"]    = "Mods/imgui"
IncludeDir["glm"]      = "Mods/glm"
IncludeDir["SOIL2"]    = "Mods/SOIL2/incs"
IncludeDir["GSL"]      = "Mods/GSL/include"
IncludeDir["spdlog"]   = "Mods/spdlog/include"


group "Dependencies"

include "Mods/GLFW"
include "Mods/Glad"
include "Mods/imgui"
include "Mods/SOIL2"

 group ""

--[[ GLOBAL Precompiled Header   
     pchheader "PCH.h"
     pchsource "MEngine/Engine/PCH.cpp"
]]


project "MEngine" 
    location "MEngine"
    kind "StaticLib"
    language "C++"
	cppdialect "C++17"
	staticruntime "on"

    pchheader "PCH.h"
    pchsource "MEngine/Engine/PCH.cpp"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir    ("bint/" .. outputdir .. "/%{prj.name}")


    files {

        "%{prj.name}/Engine/**.h",
        "%{prj.name}/Engine/**.cpp",

    }

	defines {

	     --"_CRT_SECURE_NO_WARNINGS"
	}

    includedirs {
	    "%{prj.name}/",
        "%{prj.name}/Engine",
     
        "%{IncludeDir.spdlog}",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.glm}",
        "%{IncludeDir.SOIL2}",
        "%{IncludeDir.GSL}"
        --"%{IncludeDir.boost}",
     
        --"$(BOOST)"
    }

    libdirs { 
        --"$(BOOST)/stage/lib" 
    }

    links { 
        "GLFW",
		"Glad",
	    "ImGui",
        "SOIL2";
		"opengl32.lib"
	}

    filter"system:windows"
        systemversion "latest"

        defines {
             "ON_ENGINE",
             "ON_WINDOW",
             "GLFW_INCLUDE_NONE"
        }

        filter "configurations:Debug"
        defines "ON_DEBUG"
		runtime "Debug"
        symbols "on"

        filter "configurations:Release"
        defines "ON_RELEASE"
		runtime "Release"
        optimize "on"


-----------------------------------
-----     PROJECT # 1 MGame     -----
-----------------------------------

project "MGame" 
    location "MGame"
    kind "ConsoleApp"
    language "C++"
	cppdialect "C++17"
	staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bint/" .. outputdir .. "/%{prj.name}")

    files {
        "%{prj.name}/Game/**.h",
        "%{prj.name}/Game/**.cpp",
    }

    includedirs {

        "MEngine/",
        "%{prj.name}/Game",
        
        "%{IncludeDir.spdlog}",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.glm}",
        "%{IncludeDir.SOIL2}",
        "%{IncludeDir.GSL}",
     
       -- "$(BOOST)"
    }

    libdirs { 
        --"$(BOOST)/stage/lib" 
    }
  
    links {
        "MEngine",
		"opengl32.lib"
    }

    filter"system:windows"
        systemversion "latest"

    defines {

         "ON_ENGINE",
         "ON_WINDOW"
    }


    filter "configurations:Debug"
        defines "ON_DEBUG"
		runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "ON_RELEASE"
		runtime "Release"
        optimize "on"
