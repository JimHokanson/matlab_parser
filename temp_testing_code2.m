clear_classes

% profile on
% 
% tic
% lex_object = mlintlib.lex(which('HDS'));
% toc
% 
% %lex_object = mlintlib.lex(which('mlintlib.lex'));
% mparser.comments(lex_object);
% profile off
% profile viewer

clear t
t = mlintlib.tester;


wtf = mlintlib.editc(t.f_wild.file_paths{1});


wtf = mlintlib.editc(which('HDS'))




wtf = mlintlib.set(t.f_wild.file_paths{1});
wtf = mlintlib.errors_and_warnings(t.getSpecificTestFilePath(4));

wtf = mlintmex(t.f_wild.file_paths{1},'-edit','-m3');
wtf = mlintmex(which('HDS'),'-edit','-m3');
wtf = mlintmex(t.getSpecificTestFilePath(1),'-calls','-m3');

wtf = t.examineUnknowns(true)

wtf = mlintlib.errors_and_warnings(which('HDS'));

str = fileread(t.getSpecificTestFilePath(1))
str(str == 13) = [];

[T,S,C] = mtreemex(str);