function [str_starts,str_ends] = getPossibleStrings(file_string)
%
%
%    [str_starts,str_ends] = mparser.strings.getPossibleStrings(file_string)    
%
%    INPUTS
%    ===========================================================
%    file_string : Contents of the file as a string
%
%    Strings are possible strings, because they might actually
%    be comments. Unfortunately my process of parsing strings
%    and comments is to get both possible strings and possible
%    comments, and then to use strings to block comments. Once
%    comments are decided, they block strings.
%
%   STATIC
%   

%TODO: Add on string recognition as inputs to functions
%that are called.
%TODO: Add checks on null input


%Start of the string
%--------------------------------------------------
%-> find a quote that is not proceeded by:
%.])}'_ or # as these generally indicate transposes
%
%a.'
%[a]'
%(a)'
%{a}'
%a'' -> surprisingly this doesn't throw an mlint warning
%a_' -> variables can end in _
%3'  -> also not useful but valid

%Addition of the start of string check nearly doubles
%our search time (^|[^chars])

bad_char_pattern = '[^\.\]\)}''\d_]';
quote_char       = '''';

start_is_string = file_string(1) == quote_char; %#ok<BDSCI>
if  start_is_string
    start_string  = ['(^|' bad_char_pattern ')' quote_char];
else
    start_string  = [bad_char_pattern quote_char];
end
%middle string
%---------------------------------------------------
%1) Don't allow line spanning
%2) Don't allow a quote, unless it is a double quote, then keep going
middle_string = ['([^\n'']|(' quote_char '))*'];

%end string
%--------------------------------------------------------------------
%- stop on a quote
end_string = quote_char;

[str_starts,str_ends] = regexp(file_string,[start_string middle_string end_string],'start','end');

%TODO: Explain this ...
str_starts = str_starts + 1;

%TODO: Explain this ...
if start_is_string
   str_starts(1) = 1; 
end

end