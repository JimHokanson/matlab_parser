
%Transpose rules:
%   1) it follows a right closing delimiter
%   2) it follows right after a variable name or function name
%   3) it follows right after a period (as part of the ".'" operator)
%   4) it follows right after another tranpose operator
%   5) A number - useless but that's how it is interpreted ...

a = 3;
b = 3;

c = [a.' + b.']'
d = 'test'
(3+4)'' +' asdf'
2' + 3'

mt = '';
wtf = 'a'''
test = 'abc''asdf' 

a_ = 3; 

%b = @
% Not a  string
% 'This is a test'

s = 'This is % a test %'