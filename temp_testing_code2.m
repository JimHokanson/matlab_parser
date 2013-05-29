clear_classes

profile on
lex_object = mlintlib.lex(which('HDS'));
%lex_object = mlintlib.lex(which('mlintlib.lex'));
mparser.comments(lex_object);
profile off
profile viewer