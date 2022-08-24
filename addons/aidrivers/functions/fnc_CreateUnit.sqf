#include "script_component.hpp"

params ["_target", "_caller"];

if !(driver _target isEqualTo objNull) exitWith {};
private _turret = assignedVehicleRole _caller select 1;
_caller moveInDriver _target;
_caller moveInTurret [_target, _turret];

private _class = switch (side _caller) do {
    case BLUFOR: {"B_Soldier_F"};
    case EAST: {"O_Soldier_F"};
    case INDEPENDENT: {"I_Soldier_F"};
    case CIVILIAN: {"C_Marshal_F"};
    default {"B_Soldier_F"};
};

private _unit = createAgent [_class, [0,0,0], [], 0, "CAN_COLLIDE"];

removeAllWeapons _unit;
removeUniform _unit;
removeVest _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit forceAddUniform uniform _caller;
_unit addVest vest _caller;
_unit addHeadGear headGear _caller;

_unit moveInDriver _target;
_unit setBehaviour "COMBAT";

SETPVAR(_target,driver,_unit);

doStop _unit;

GVAR(LastTimeIn) = CBA_missionTime;

[{!((vehicle (_this select 0)) isEqualTo (_this select 0))}, { //waiting for spawned unit to get into vehicle
    private _pfhHandle = [{
        params ["_args","_pfhID"];
        _args params ["_unit", "_target", "_caller"];

        if !(vehicle _caller isEqualTo _target) then {
            [false] call FUNC(toggleDriverCam);
            _unit disableAI "Path";
            doStop _unit;
        } else {
            _unit enableAI "Path";
            GVAR(LastTimeIn) = CBA_missionTime;
        };
        if ((CBA_missionTime > 30 + (GETMVAR(LastTimeIn,CBA_missionTime)))
            || {!alive _target}
            || {!alive _caller}
            || {!alive _unit}
            || {!(vehicle _unit isEqualTo _target)}
            || {!(driver _target isEqualTo _unit)}
            || {((GETVAR(_target,driver,objNull)) isEqualTo objNull)}
        ) exitwith {
            [_target, _caller] call FUNC(removeUnit);
            [_pfhID] call CBA_fnc_removePerFrameHandler;
        };
    }, 1, _this] call CBA_fnc_addPerFrameHandler;
    SETPVAR((_this select 1),pfhID,[ARR_2((_this select 2), _pfhHandle)]);
}, [_unit, _target, _caller]] call CBA_fnc_WaitUntilAndExecute;

GVAR(Vehicle) = _target;
hintSilent "Driver Added";
