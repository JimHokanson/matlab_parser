classdef comments < handle
    %comments  Should parse comments from a file ...
    %   
    %   Class:
    %   mparser.comments
    
    %{
    Testing code:
    
    %}
    
    properties
       starts
       ends
       line_starts
       line_ends
       type
       content_strings
    end
    
    methods
        function obj = comments(file_path,file_string)
           %
           %    obj = mparser.comments(file_path,*file_string)
           %
           %    INPUTS
           %    ===========================================================
           %    file_string : Contents of the file as a string
           
           lex_output = 
           
           %TODO:
           %??? Build these into the library???
           %1) Resolve unique instances
           %2) Lines to index 
           
        end
    end
    
end

