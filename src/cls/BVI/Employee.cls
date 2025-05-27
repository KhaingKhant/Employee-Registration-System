Class BVI.Employee Extends (%Persistent, %XML.Adaptor)
{

Property EmployeeNumber As %String(MAXLEN = 3) [ Required ];

Property NameKanji As %String(MAXLEN = 50) [ Required ];

Property NameKana As %String(MAXLEN = 50) [ Required ];

Property Address As %String(MAXLEN = 100) [ Required ];

Index EmpNumIndex On EmployeeNumber [ Unique ];

/// Validation for Zenkaku characters (including space)
ClassMethod ValidateZenkaku(input As %String) As %Boolean
{
    If input = "" Quit 0
    
    // Check if string contains only:
    // - CJK Unified Ideographs (Kanji): \x{4E00}-\x{9FAF}
    // - Hiragana: \x{3040}-\x{309F}
    // - Katakana: \x{30A0}-\x{30FF}
    // - Full-width punctuation: \x{3000}-\x{303F}
    // - Full-width forms: \x{FF00}-\x{FFEF}
    // - Ideographic space: \u3000
    Quit $MATCH(input, "^[\x{4E00}-\x{9FAF}\x{3040}-\x{309F}\x{30A0}-\x{30FF}\x{3000}-\x{303F}\x{FF00}-\x{FFEF}\u3000]+$")
}

/// Validation for Hankaku characters (including space)
ClassMethod ValidateHankaku(input As %String) As %Boolean
{
    If input = "" Quit 0
    
    // Check if string contains only:
    // - Half-width Katakana: \x{FF66}-\x{FF9F}
    // - ASCII space
    Quit $MATCH(input, "^[\x{FF66}-\x{FF9F} ]+$")
}

/// Validate employee number format
ClassMethod ValidateEmployeeNumber(num As %String) As %Boolean
{
    Quit (num?4N) || (num?3N) || (num?2N) || (num?1N)
}

Storage Default
{
<Data name="EmployeeDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>EmployeeNumber</Value>
</Value>
<Value name="3">
<Value>NameKanji</Value>
</Value>
<Value name="4">
<Value>NameKana</Value>
</Value>
<Value name="5">
<Value>Address</Value>
</Value>
</Data>
<DataLocation>^BVI.EmployeeD</DataLocation>
<DefaultData>EmployeeDefaultData</DefaultData>
<IdLocation>^BVI.EmployeeD</IdLocation>
<IndexLocation>^BVI.EmployeeI</IndexLocation>
<StreamLocation>^BVI.EmployeeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
