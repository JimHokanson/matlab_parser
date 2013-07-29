classdef errors_and_warnings < mlintlib
    %
    %   Class:
    %   mlintlib.errors_and_warnings
    %
    %
    %   Status: The default messages are not that useful. I'm currently
    %   looking through all flags to find the best one for thigs type of
    %   information ...
    %
    %   NOTE: Not a lot of detail is available ...
    %   m3 - nothing?? - seems to return fatal errors ...
    %   m2 - errors only
    %   m1 - errors and severe warnings only
    %   m0 - all errors and warnings
    %
    %
    %   Related:
    %   -mess  ??What does this do???
    %   -all   ??I think this ignores things specified as ok
    %   -id    Returns ids
    %
    %   L 7 (C 9): SYNER: Parse error at '<EOL>': usage might be invalid MATLAB syntax.
    %
    %   Fatal errors are indicated in -lex by:
    %   1/10(10): <NAME>:  fatalError
    
    properties
        
    end
    
    methods
        function obj = errors_and_warnings(file_path)
            %
            %   ??? - what does fix mean????
            %
            
            
            %NOTE: I might remove the filter level and calculate all
            
% % %             if ~exist('filter_level','var')
% % %                 flag = '-m0';
% % %             else
% % %                 %TODO: test range
% % %                 assert(filter_level >= 0 && filter_level <= 2,'Filter level must be between 0 and 2')
% % %                 flag = sprintf('-m%d',filter_level);
% % %             end
            
            %Do I want to output a struct or the string
            %The string looks a bit better and it is easy to get
            %the struct ...
            
            %obj.raw_file_string = fileread(file_path);
            
            tic
            for i = 1:1000
            temp = mlintmex(obj.raw_file_string,'-text','-all','-id','-struct');
            end
            toc
            
            tic
            for i = 1:1000
            raw_string = mlintmex(file_path,'-all','-id');
            end
            toc
            
            
            
            
            s = temp{1}; %Output is a cell array :/
            
            ids = {s.id};
            
            levels = mlintlib.all_msg.getIDLevels(ids);
            
            keyboard

            
            
        end
    end
    
end

