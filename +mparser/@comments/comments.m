classdef comments < handle_light
    %   
    %   Class:
    %   mparser.comments
    %
    %   Functionality
    %   ===================================================================
    %   1) Given a series of definition lines
    
    %{
    Testing code:
    
    %}
    
    properties
    end
    
    properties
        
    end
    
    methods
        function obj = comments(lex_object)
           
            
           %NOTE: I am not sure what I want this class to accomplish ...
           
           
           
           
           %
           %
           %TODO:
           %??? Build these into the library???
           %1) Resolve unique instances
           %2) Lines to index 
           
           %What I want:
           %indices of each of these preferably sorted by original order
           %but with group ids of which are which ...
           %i.e. something like
           %1 2  3  4  5  6
           %---------------------------------------------------------------
           %1 10 20 30 51 70 <= original indices
           %1 2  1  3  1  2  <= type, based on request
           %{1 3 5}          <= for each request, which are of this type ...
           %{2 6}
           %{4}
           
%            [indices,type_id,groups] = lex_object.getTypeIndices({'%' '{%' '%}'});
%            
%            %NOTE: For group comments, each line within the comment is
%            %actually a comment as well ...
%            
%            comment_strings = lex_object.getStringsForIndices(indices(groups{1}));
%            
%            %Next, form groups:
%            comment_lines = lex_object.line_numbers(indices);
           
           %keyboard
        end
        %Functions:
        % - merge comment lines
        % - 
    end
    
end

