p = '((?<!]\)}\w\.'')''';
%p = '((?<!\.\.)[^\.])|[^''%]'
s = '[a.'' - b'']';

str = fileread('string_parsing_test.m');

str(regexp(str,'(?<!]\)\.)''')-1)

start_string = '(?<![\.\]\)}''\d])''';



%Rules
%1) Test for empty string ...
%2) Go until a ' not proceeded
%by another '
%=> odd #

middle_string = '([^\n'']|(''''))*';
end_string = '''';

[m,s,e] = regexp(str,[start_string middle_string end_string],'match','start','end');

m