class GVAR(AdditionalLanguageAttribute): Combo {
    //save the lbData from the selected entry upon exit
    attributeSave = "\
        private _value = ((_this controlsGroupCtrl 100) lbData lbCurSel (_this controlsGroupCtrl 100));\
        private _unit = ((get3denselected 'object') select 0);\
        private _name = gettext (_config >> 'property');\
        _unit setvariable [_name,_value];\
        _value\
    ";
    //_this - config, _value - saved value
    attributeLoad="\
        private _control = (_this controlsGroupCtrl 100);\
        private _name = gettext (_config >> 'property');\
        private _unit = ((get3denselected 'object') select 0);\
        private _nameArray = ['None','English','Russian','French','Arabic','Greek','BluforCustomLanguage1','BluforCustomLanguage2','OpforCustomLanguage1','OpforCustomLanguage2','IndforCustomLanguage1','IndforCustomLanguage2','CivCustomLanguage1','CivCustomLanguage2'];\
        {\
            private _index = _control lbadd _x;\
            _control lbsetdata [_index,_x];\
            _control lbsetValue [_index,_foreachIndex];\
            if (_value isEqualto (_control lbData _index)) then {\
                _control lbSetCurSel _index;\
                _unit setvariable [_name,_value];\
            };\
        } foreach _nameArray;\
    ";
    class Controls: Controls {
        class Title: Title {};
        class Value: Value {};
    };
};
