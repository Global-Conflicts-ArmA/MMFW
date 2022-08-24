/*
 * Author: Olsen
 *
 * picks a random number from set range.
 *
 * Arguments:
 * 0: min <number>
 * 1: max <number>
 *
 * Return Value:
 * random integer <number>
 *
 * Public: No
 */


#include "script_component.hpp"

params [
    ["_min", 0, [0]],
    ["_max", 1, [1]]
];

private _return = _min + (floor(random (1 + _max - _min)));

_return
