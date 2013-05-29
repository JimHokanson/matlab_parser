classdef calls < handle_light
    %
    %
    %   Class:
    %   mlintlib.calls
    %
    %   This class exposes the mlintmex function with the '-calls' input.
    %
    %   From what I can tell, this is equivalent to the '-callops' input.
    %
    %   ISSUES:
    %   ==================================================================
    %   1) There is information in this function as to when a function
    %   starts and when it ends, but this is not being processed. I'm not
    %   sure what functions get this information (all with an end
    %   statement?) and whether the end specification always immediately follows
    %   the start specification or not.
    
    properties
       %Following are properties that are parsed from the mlintmex call.
       %-------------------------------------------------------------------
       line_numbers     %[1 x n]
       column_start_indices %[1 x n]
       types            %[1 x n], this describes the type of function call
       %such as a main function, anonymous, or sub-function
       %See private\function_call_types.m for more
       depths           %[1 x n], depth in the file of the function call,
       %Top most functions are at depth 0. 
       call_names       %Name of the function or call being made. Anonymous
       %functions lack a name.
    end
    
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
            % U0 27 31 zeros
            % U0 36 31 cell
            % S0 76 24 get.parent
            % E0 98 11 get.parent
            % U1 88 19 dbstack
            % U1 89 17 isempty
            % U1 90 21 any
            % U1 90 25 strcmp
            % U1 91 27 subsref
            % U1 91 40 substruct
            % S0 104 24 HDS
            % E0 207 11 HDS
            % U1 107 39 clock
            % U1 108 39 uint32
            % U1 111 39 zeros
            % U1 111 45 length
            % U1 126 17 strcmp
            % U1 126 24 class
            % U1 128 27 regexp
            
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

