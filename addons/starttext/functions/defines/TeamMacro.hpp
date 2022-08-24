#define STARTTEXTTEAMMACRO(TEAMNAMEVAR) \
private _TitleQuoteVar = GETMVAR(DOUBLES(TitleQuote,TEAMNAMEVAR),"");\
private _textVar = GETMVAR(DOUBLES(Text,TEAMNAMEVAR),"");\
if !(_TitleQuoteVar isEqualto "") then {\
    _startTextArray pushBack [4, _TitleQuoteVar];\
};\
if !(_textVar isEqualto "") then {\
    _startTextArray pushBack [3, _textVar];\
}
