classdef lex < handle_light
    %
    %   Class:
    %   mlintlib.lex
    %
    %   This class exposes the mlintmex function with the '-lex' input.
    %
    %   ISSUES:
    %   ==================================================================
    
    %Properties Per Entry
    %----------------------------------------------------------------------
    properties
        %Following are the properties that are parsed from the mlintmex
        %call.
        %------------------------------------------------------------------
        line_numbers            %[1 x n], For each parsed entry, this 
        %indicates the line number that the entry is on
        column_start_indices    %[1 x n], For each parsed entry
        lengths                 %[1 x n], " " length of content, for some
        %types this is the type itself (if,end,+,-, etc), for others 
        types                   %[1 x n], string name indicating type
        %See private\type_notes for more details
        strings                 %[1 x n], NOT YET IMPLEMENTED
        
        %TODO: Lazy evaluation
        absolute_start_indices %[1 x n], Instead of a line number and column
        %index, this provides an absolute index into the string of the file
        %as to where the content starts.
    end
    
    
    %TODO: Make things below private????
    %Would like local tab completion but hidden display
    %Might need to finish help display class to get this ...
    properties
       %.getAbsoluteStartIndices() 
       newline_indices 
    end
    
    properties
       unique_types_map  %(class: containers.map), keys are the unique 
       %types and values are the array indices that have the specified type
    end
    
    properties
        file_path
        file_string
        raw_mex_output
    end
    
    
    methods
        function obj = lex(file_path,file_string)
            
            obj.file_path = file_path;
            if exist('file_string','var')
               obj.file_string = file_string;
            else
               obj.file_string = fileread(file_path);
            end
            
            %NOTE: The -m3 specifies not to return mlint messages
            obj.raw_mex_output    = mlintmex(file_path,'-lex','-m3');
            
            %Sample output of raw
            %--------------------------------------------------------------------------
            % 1868/13(2): IF:  IF
            % 1868/16(7): <NAME>:  isempty
            % 1868/23(1): '(':  '('
            % 1868/24(14): <NAME>:  HDSManagedData
            % 1868/38(1): '(':  '('
            
            %NOTES: 
            %   - It is possible that this could be optimized a bit further
            %   - We might want to extract property names here ...
            %   - textscan is used to allow numeric value extraction as
            %   opposed to regexp which would require string to number
            %   conversion in Matlab which is sadly very slow
            %   - %*[] - don't return match to output
            c = textscan(obj.raw_mex_output,'%f / %f ( %f ): %s %[^\n]','MultipleDelimsAsOne',true);
            
            %?? Consider delaying the 5th output until requested?
            %Use regexp instead at that point, look for ':  '[^\n]*
            
            %NOTE: Our delimeter is the default (a space). The middele part
            %which specifies the type ends in a colon which is not meant to
            %be included, but filtering on a colon messes up the situation
            %in which the colon character is the type. We use a regular
            %expression below
            
            obj.line_numbers         = c{1}';
            obj.column_start_indices = c{2}';
            obj.lengths              = c{3}';
            
            %NOTE: At this point, some of these are invalid as they
            %get truncated when they are too long. We can use the length
            %observed versus their specified lengths to determine when this
            %happens and fix them. See .fixStrings
            obj.strings              = c{5}';
            
            %Tricky one: '':''
            %[^''] - matches a character if it isn't a quote -> matches the colon
            obj.types = regexp(c{4},'[^''][^:'']*','match','once')';
            
            %TODO: Eventually these should undergo lazy evaluation
            %At its base level, the class should just return information
            %from the mex function
            obj.getAbsoluteStartIndices();
            obj.getUniqueGroups();
            obj.fixStrings();
        end
    end
    
    methods (Hidden)
        function fixStrings(obj)
            
           observed_lengths     = cellfun('length',obj.strings);
           short_string_indices = find(obj.lengths > observed_lengths);
           
           if isempty(short_string_indices)
               return
           end
           
           %??? Would the addition of the ellipsis ever cause the lengths
           %to match?????
           %i.e. my short string t...
           %->   my short string test
           
           short_starts = obj.absolute_start_indices(short_string_indices);
           short_ends   = short_starts + obj.lengths(short_string_indices) - 1;
           
           str = obj.file_string;
           
           all_strings = obj.strings;
           obj.strings = {};
           for iShort = 1:length(short_string_indices);
              all_strings{short_string_indices(iShort)} = str(short_starts(iShort):short_ends(iShort));
           end
           obj.strings = all_strings;
        end
        function getAbsoluteStartIndices(obj)
           %getAbsoluteStartIndices
           % 
           %    getAbsoluteStartIndices(obj)
           
           %NOTE: We can't rely on EOL parsing for returning all 
           %end of lines, as EOL signifies the line with the end of the
           %statement, and ignores ... lines
           I_newline = strfind(obj.file_string,sprintf('\n'));
           index_of_previous_line_end = [0 I_newline];
           
           obj.absolute_start_indices = ...
                        index_of_previous_line_end(obj.line_numbers) ...
                                    + obj.column_start_indices;
                                
           obj.newline_indices = I_newline;                     
        end
        function getUniqueGroups(obj)
           [unique_types,unique_types__indices_ca] = ...
                unique2(obj.types);

            obj.unique_types_map = containers.Map(unique_types,unique_types__indices_ca);

        end
    end
end

