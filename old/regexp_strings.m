%??? - what about load/save functons
%import name stuff

iby = (@(x,y)(x:x+y));

h = which('regex_tools.findCommentPattern');
h = which('NEURON.simulation.extracellular_stim');
h = which('string_parsing_test');

code = fileread(h);
%Fix newlines
code = regexprep(code,'\r\n?','\n');

%Remove trailing junk
code = regexprep(code,'[ \t]+(\n|$)','\n');

block_comment_line_start = '^[ \t]*+%{[ \t]*+\n';
block_comment_line_end   = '^[ \t]*+%}[ \t]*+\n';

block_comment_pattern = ['(?<block_comment>' block_comment_line_start '.*?' block_comment_line_end ')'];

easy_comment_line = '(?<easy_comment>^[ \t]*+%.*\n)';

empty_line = '(?<empty_line>^\n)';

%a''' + b'

p_kw           = '(?<properties>[ \t]*+properties\>.*\n)';
m_kw           = '(?<methods>[ \t]*+methods\>.*\n)';
event_kw       = '(?<events>[ \t]*+events\>.*\n)';
enumeration_kw = '(?<enum>[ \t]*+enumeration\>.*\n)';
end_kw         = '(?<end>[ \t]*+end\>.*\n)';
f_kw           = '(?<function>[ \t]*+function\>.*\n)';

% FOR, WHILE, SWITCH, TRY, and IF

if_kw  = '(?<if_kw>[ \t]*+if\>.*\n)';

keyword_patterns = [p_kw '|' m_kw '|' event_kw '|' enumeration_kw '|'  end_kw '|' f_kw '|' if_kw];

pattern = [block_comment_pattern '|' empty_line '|' easy_comment_line '|' keyword_patterns];

%Other strings to match ...
%classdef,properties, etc

tic
[wtf,wtf2] = regexp(code,pattern,'lineanchors','dotexceptnewline','names','tokenExtents');
toc

%String matching
%----------------------------------

%-> find ' not proceeded by:
%.])}'_ or # - these are generally transposes
%
%a.'
%[a]'
%(a)'
%{a}'
%a'' -> surprisingly this doesn't throw an mlint warning
%a_' -> variables can end in _
%3'  -> also not useful but valid

%WOW: THIS IS SUPER SLOW!
%start_string  = '(?<![\.\]\)}''\d_])''';

%Add on start of line
start_string  = '[^\.\]\)}''\d_]''';

%middle string
%
%1) Don't allow line spanning
%2) Don't allow a quote, unless it is a double quote, then keep going
middle_string = '([^\n'']|(''''))*';

%end string
%- stop on a quote
end_string = '''';


[str_starts,str_ends] = regexp(code,[start_string middle_string end_string],'start','end');

%The string start mathes the invalid character before the true start (with
%current regexp), not the start character
str_starts = str_starts + 1;

%TODO: Need to fix the case where the first character is the
%start of a string, which currently fails since we require a character that
%is not invalid (an invalid character indicates a transpose, not a string
%start)
%
%   The fix involves either prepending a padding character on the regexp()
%   above or doing an additional one if the test below works. Not sure
%   which is better. Alternatively, one could rewrite the regexp to test for
%   the start of the string OR a valid character to proceed the apostrophe.
%   => ^|[^\.\] etc 
if code(1) == ''''
   error('Please fix code') 
end

%These are possible strings, because if we find that they follow the start
%of a comment, then they are part of the comment, not a string
is_possible_string = false(1,length(code));
for iString = 1:length(str_starts)
   is_possible_string(str_starts(iString):str_ends(iString)) = true; 
end

possible_comment_starts = regexp(code,'%|\.{3}');

%Basically, this line says, if we think it is a string, then there is no
%way that we have found a comment start
possible_comment_starts = possible_comment_starts(~is_possible_string(possible_comment_starts));

%At this point, the above are only possible comment starts because they
%might be a comment within a comment, which would not indicate the comment
%start
%
%   For example   %This is a comment with %%%% chars, which are not starts

line_starts = [1 regexp(code,'\n') + 1];

%TODO: How to only grab the first one after each line?
%=> cumsum to apply line ID
%=> diff to find transitions

line_ids = zeros(1,length(code));
line_ids(line_starts) = 1;
line_ids = cumsum(line_ids);

possible_comment_start_line_ids = line_ids(possible_comment_starts);

comment_starts = possible_comment_starts([true diff(possible_comment_start_line_ids) ~= 0]);

%TODO: At this point we would need to do some filtering of the comments
%Leave for a later function

%Outputs:
%----------------------------------------
%1) comment start
%2) comment end => how to define this???
%3) comment_type => 
%
%   block               
%           %{
%   
%           }%
%   after_content   a = 3 %my comment
%   isolated_line   %my_comment
%   continuation    b = {3,4,... comment string

%Next Steps:
%1) Isolate comment stuffs to function
%2) Build answer comparision with Java classes
%=> Could test on all code in our repository 

%NOTE: This can also be used to identify strings, not sure how
%to encapsulate these ...


