classdef calls < sl.obj.handle_light
    %
    %
    %   Class:
    %   mlintlib.calls
    %
    %   This class exposes the mlintmex function with the '-calls' input.
    %
    %   From what I can tell, this is equivalent to the '-callops' input.
    %
    %
    %   1)
    
    %
    %   ISSUES:
    %   ==================================================================
    %   1) There is information in this function as to when a function
    %   starts and when it ends, but this is not being processed. I'm not
    %   sure what functions get this information (all with an end
    %   statement? i.e. functions don't require end but they all
    %   functionally "end") and whether the end specification
    %   always immediately follows the start specification or not or
    %   whether it is logically arranged.
    %
    %   See Also:
    %
    
    properties
        d0 = '----  From raw mlintmex call   ----'
        %Following are properties that are parsed from the mlintmex call.
        %-------------------------------------------------------------------
        line_numbers         %[1 x n]
        column_start_indices %[1 x n]
        types %[1 x n], this describes the type of function call
        %such as a main function, anonymous, or sub-function
        %
        %A - anonymous function
        %M - main method in file
        %E - end of function
        %  - I think this doesn't exist for anonymous functions
        %N - nested functions
        %S - subfunction, functions in classdef including constructors show up as
        %   this, not as M
        %U - called function - functions outside their scope, undefined
        
        depths           %[1 x n], depth in the file of the function call,
        %Top most functions are at depth 0.
        call_names       %{1 x n} Name of the function or call being made.
        %Anonymous functions lack a name.
    end
    
    %Possible analysis
    %------------------------------------------------------------
    %- fcn start line
    %- is_anonymous
    %- is_nested
    %- fcn end line
    
    properties
        file_path
        raw_mex_output
    end
    
    methods
        function obj = calls(file_path)
            obj.file_path = file_path;
            
            %NOTE: The -m3 specifies not to return mlint messages
            obj.raw_mex_output    = mlintmex(file_path,'-calls','-m3');
            
            %--------------------------------------------------------------
            
            
            c = textscan(obj.raw_mex_output,'%*s %f %f %s');
            
            obj.line_numbers         = c{1}';
            obj.column_start_indices = c{2}';
            obj.call_names           = c{3}';
            
            c2 = regexp(obj.raw_mex_output,'^(?<type>\w+)(?<depth>\d+)','lineanchors','names');
            
            obj.types  = {c2.type};
            
            all_depths = {c2.depth};
            
            dep_length     = cellfun('length',all_depths);
            is_single_char = dep_length == 1;
            
            if all(is_single_char)
                %double('0') => 48
                obj.depths = [c2.depth] - 48;
            else
                %final_depths = zeros(1,length(all_depths));
                error('Not yet implemented')
                %obj.depths = cellfun(@(x) x - 48,all_depths);
            end
        end
    end
    
end

