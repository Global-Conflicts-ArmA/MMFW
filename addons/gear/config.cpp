#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "MMFW_main",
            "MMFW_core",
            "ace_arsenal"
        };
        authors[] = {"Olsen", "PiZZADOX"};
        author = "MMFW Team";
        authorUrl = "https://github.com/Global-Conflicts-ArmA/MMFW";
        VERSION_CONFIG;
    };
};

#include "\z\MMFW\addons\main\RscTitles.hpp"
#include "cfgGear\GearPresets.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
#include "Cfg3DEN.hpp"
