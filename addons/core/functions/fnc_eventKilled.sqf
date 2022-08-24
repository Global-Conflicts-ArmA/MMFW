/*
 * Author: Olsen
 *
 * Triggered by unit death. Decreases number of alive units on a set side in MMFW_Core_Teams.
 *
 * Arguments:
 * 0: unit that has died <object>
 * 1: killer of the unit <object> (OPTIONAL)
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "script_component.hpp"

params [
    ["_unit", objNull, [objNull]],
    ["_killer", objNull, [objNull]]
];

if (GETVAR(_unit,Tracked,false)) then {
    GVAR(Teams) apply {
        _x params ["", "_side", "_type", "", "_current"];
        if (!(GETVAR(_unit,HasDied,false)) && {!(GETVAR(_unit,Dead,false))} && {(GETVAR(_unit,Side,sideUnknown) isEqualto _side)} && {((_type isEqualto "player" && {isPlayer _unit}) || (_type isEqualto "ai" && !(isPlayer _unit)) || (_type isEqualto "both"))}) exitWith {
            SETPVAR(_unit,HasDied,true);
            SETPVAR(_unit,Dead,true);
            _x set [4, (_current - 1)];
        };
    };
};
