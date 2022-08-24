#include "script_component.hpp"
EXEC_CHECK(CLIENT);

params [["_startTextArray", [], [[]]]];

date params ["_yearDate", "_monthDate", "_dayDate", "_hourDate", "_minuteDate"];

private _month = switch (_monthDate) do {
    case 1: {"January"};
    case 2: {"February"};
    case 3: {"March"};
    case 4: {"April"};
    case 5: {"May"};
    case 6: {"June"};
    case 7: {"July"};
    case 8: {"August"};
    case 9: {"September"};
    case 10: {"October"};
    case 11: {"November"};
    case 12: {"December"};
    default {"January"};
};

private _day = switch (_dayDate mod 10) do {
    case 1: {format ["%1st", _dayDate]};
    case 2: {format ["%1nd", _dayDate]};
    case 3: {format ["%1rd", _dayDate]};
    case 11: {format ["%1st", _dayDate]};
    case 12: {format ["%1nd", _dayDate]};
    case 13: {format ["%1rd", _dayDate]};
    case 21: {format ["%1st", _dayDate]};
    case 22: {format ["%1nd", _dayDate]};
    case 23: {format ["%1rd", _dayDate]};
    case 31: {format ["%1st", _dayDate]};
    default {format ["%1th", _dayDate]};
};

if (_minuteDate isEqualto 60) then {
    _hourDate = _hourDate + 1;
    _minuteDate = 0;
};
private _hour = if (_hourDate < 10) then {
    "0" + format ["%1", _hourDate];
} else {
    format ["%1", _hourDate];
};
private _min = if (_minuteDate < 10) then {
    "0" + format ["%1H", _minuteDate];
} else {
    format ["%1H", _minuteDate];
};

private _unparsedText = "<t align='right' size='1.2'>";

for "_i" from 0 to ((count _startTextArray) -1) do {
    private _line = _startTextArray select _i;
    switch (_line select 0) do {
        case 0: {
            _unparsedText = _unparsedText + format ["%2 %3", _day, _month];
        };
        case 1: {
            _unparsedText = _unparsedText + format ["%1", (_hour + _min)];
        };
        case 2: {
            _unparsedText = _unparsedText + format ["%1, %2 %3", (_hour + _min), _day, _month];
        };
        case 3: {
            _unparsedText = _unparsedText + format ["%1", _line select 1];
        };
        case 4: {
            _unparsedText = _unparsedText + format ["<t font='PuristaBold' size='1.6'>""%1""</t>", _line select 1];
        };
        default {
            _unparsedText = _unparsedText + format ["<t font='PuristaBold' size='1.6'>%1</t>", _line select 1];
        };
    };

    if (_i < count _startTextArray -1) then {
        _unparsedText = _unparsedText + "<br/>";
    }
};

_unparsedText = _unparsedText + "</t>";

LOG_1("Executing Start Text with %1",_unparsedText);

[{(CBA_missionTime > 10)},{
    _this spawn BIS_fnc_textTiles;
},[parsetext _unparsedText, true, nil, 10, 0.7, 0]] call CBA_fnc_WaitUntilAndExecute;
