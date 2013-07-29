classdef mlintlib < sl.obj.handle_light
    %
    %   Class:
    %   mlintlib
    %
    %   NOTE: I might put some static methods here as well
    %   as some notes on variables names for creating
    %   interface methods
    %
    %
    %   IDEAS
    %   ==================
    %   - resolve line number and column to absolute indices
    %   - PROPS:
    %       - file path
    %       - file string
    %
    %   
    %   See Also:
    %   mlintlib.all_msg
    %   mlintlib.calls
    %   mlintlib.editc
    %   
    %   mlintlib.lex
    %   
    %   mlintlib.tab
    %   mlintlib.set
    
    
    properties
       d3 = '----   mlintlib super props   ----';
       file_path
       
       raw_mex_string
       %raw_mex_newline_indices
       raw_mex_lines

       raw_file_string
       raw_file_newline_indices
       raw_file_lines
    end
    
    %Get Methods ==========================================================
    methods
        %raw file methods ---------------------------
        function value = get.raw_file_string(obj)
            value = obj.raw_file_string;
            if isempty(value)
               value = fileread(obj.file_path);
               obj.raw_file_string = value;
            end
        end
        function value = get.raw_file_newline_indices(obj)
           value = obj.raw_file_newline_indices();
           if isempty(value)
              value = strfind(obj.raw_file_string,sprintf('\n'));
              obj.raw_file_newline_indices = value;
           end
        end
        function value = get.raw_file_lines(obj)
           value = obj.raw_file_lines;
           if isempty(value)
              value = regexp(obj.raw_file_string,'\n','split');
              obj.raw_file_lines = value;
           end
        end
        %raw mex methods -------------------------------
        function value = get.raw_mex_lines(obj)
           value = obj.raw_mex_lines;
           if isempty(value)
              value = regexp(obj.raw_mex_string,'\n','split');
              obj.raw_mex_lines = value;
           end
        end
    end
    
    %Shared Methods =======================================================
    methods
        
    end
end

