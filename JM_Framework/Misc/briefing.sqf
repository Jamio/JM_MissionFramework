// briefing.sqf - Unified Structured Briefing System

waitUntil {!(isNil "JM_BriefingContent")};

#define DISPLAYBRIEFING() \
_size = count _briefing - 1; \
for '_i' from 0 to _size do { \
    player createDiaryRecord (_briefing select _size - _i); \
};

// Colors and Fonts
#define HEADER_COLOR "#0352fc"
#define SUBHEADER_COLOR "#fcba03"
#define FONT_FACE "PuristaSemiBold"
#define HEADER_SIZE "18"
#define SUBHEADER_SIZE "14"
#define TEXT_SIZE "12"

// Initialize briefing array
private _briefing = [];

// Iterate through each section in JM_BriefingContent
{
    private _sectionName = _x select 0;
    private _subSections = _x select 1;

    // Start the section with the header
    private _sectionText = format ["<br/><font color='%1' size='%2' face='%3'><b>%4</b></font><br/><br/>", 
        HEADER_COLOR, HEADER_SIZE, FONT_FACE, _sectionName];

    // Process each subsection if _subSections is a valid array
    if (typeName _subSections == "ARRAY") then {
        {
            if (typeName _x == "ARRAY" && {count _x == 2}) then {
                private _subHeader = _x select 0;
                private _body = _x select 1;

                // Append each subsection properly
                _sectionText = _sectionText + format ["<br/><font color='%1' size='%2' face='%3'><b>%4</b></font><br/>%5<br/><br/>", 
                    SUBHEADER_COLOR, SUBHEADER_SIZE, FONT_FACE, _subHeader, _body];
            };
        } forEach _subSections;
    };

    // Push the final formatted entry into the diary
    _briefing pushBack ["Diary", [_sectionName, _sectionText]];
} forEach JM_BriefingContent;

DISPLAYBRIEFING();
















