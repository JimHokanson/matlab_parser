%{
TYPE_NOTES

This is meant to document the different types that are parsed
out from the lex parser.

See: mlintlib.lex

??? - are these seen in other functions?


'%' - line comment, these also seem to appear for continuation comments 
      i.e. => something ... this is a comment
    - They also appear for lines that make up group comments, except for
    the start and end lines, which are indicated as group comment lines
'&' 
'&&'
'('
')'
'*'
'+'
','
'-'
'.'
':'
';'
'<'
'<='
'<DOUBLE>'
'<EOL>' - end of line character. NOTE, for lines with '...'
        the EOL character is not present. This points to the \n character.
'<INT>'
'<NAME>'
'<STRING>'
'='
'=='
'>'
'@'
'BREAK'
'CASE'
'CATCH'
'CLASSDEF'
'CONTINUE'
'ELSE'
'ELSEIF'
'END'
'FOR'
'FUNCTION'
'GLOBAL'
'IF'
'METHODS'
'NUL'
'OTHERWISE'
'PERSISTENT'
'PROPERTIES'
'RETURN'
'SWITCH'
'TRY'
'WHILE'
'['
']'
'{'
'||'
'}'
'~'
'~='

NOT PRESENT   =============================================================
...

%}