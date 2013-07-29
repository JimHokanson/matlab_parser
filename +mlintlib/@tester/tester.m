classdef tester < sl.obj.handle_light
    %
    %   Class:
    %   mlintlib.tester
    
    %The goal is to run a function over a bunch of files ...
    
    
    %-com -> from mtree -> comments should be included
    %Which does this effect?
    %TODO: write double testing function
    %
    properties
       %Known to be invalid:
       %
       ALL_KNOWN_FUNCTIONS = {'-all' '-allmsg' '-amb' '-body' '-callops' ...
           '-calls' '-com' '-cyc' '-db' '-dty' '-edit' '-en' '-id' '-ja' ...
           '-lex' '-m0' '-m1' '-m2' '-m3' '-mess' '-msg' '-notok' '-pf' ...
           '-set' '-spmd' '-stmt' '-tab' '-tmree' '-tmw' '-toks' '-tree' ...
           '-ty' '-ud' '-yacc'}; 
       UNKNOWN_FUNCTIONS = {'-all' '-body' '-com' '-pf' '-spmd' '-toks'}; 
       %Since learned:
       %all - all mlint, even those that are ok (I think), still to check
       %com - comments - from mtree, effects ???
       %pf  - parfor, info on parfor loops
       %spmd - spmd is a matlab construct, this function finds these
       %constructs
    end
    
    properties
       f_wild       %@type=sl.dir.file_list_result
       f_specific
    end
    
    methods
        function obj = tester()
           mlintlib_path       = sl.dir.getMyBasePath('',1); 
           wild_code_base_path = fullfile(mlintlib_path,'tests','wild_code');
           obj.f_wild          = sl.dir.getFilesInFolder(wild_code_base_path);
           
           test_base_path = fullfile(mlintlib_path,'tests');
           obj.f_specific = sl.dir.getFilesInFolder(test_base_path);
        end
        function test_path = getSpecificTestFilePath(obj,index)
           test_path = obj.f_specific.file_paths{index};
        end
        function output = examineUnknowns(obj,use_wild)
           
            if use_wild
           file_paths_test = obj.f_wild.file_paths; 
            else
              file_paths_test = obj.f_specific.file_paths;   
            end
           options_test    =  obj.UNKNOWN_FUNCTIONS;
           
           n_files   = length(file_paths_test);
           n_options = length(options_test);
           output = cell(n_files+1,n_options+1);
           output(1,2:end) = options_test;
           for iFile = 1:n_files
               output(iFile+1,1) = {iFile+1};
               for iOption = 1:n_options
                  output{iFile+1,iOption+1} = mlintmex(file_paths_test{iFile},options_test{iOption},'-m3');
               end
           end
        end
        function higherOrderTester()
           %The goal of this function is to test unknowns in conjunction
           %with the known flags to see if the known flags change because
           %of the unknowns
        end
    end
    
end

