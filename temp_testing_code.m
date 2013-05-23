%Temp testing code

h           = which('HDS');
str = fileread(h);

tic
N = 1000;
for i = 1:N
[s,e] = mparser.strings.getPossibleStrings(str); 
end
disp(toc/N)