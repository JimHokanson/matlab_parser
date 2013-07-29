classdef all_msg < sl.obj.handle_light
    %
    %   Class:
    %   mlintlib.all_msg
    %
    %   Access via:
    %   mlintlib.all_msg.getInstance
    
    properties
        ids    %{n x 1}
        
        %TODO: I'd like to name these
        levels  %[n x 1]
        %0 - aesthetics
        %1 -
        %5 - information and metrics
        msgs   %{n x 1}
        type_indices %[1 x n]
        
        type_id    %{1 x m}
        type_names %{1 x m}
        type_group_indices %{1 x m} indices of the ids
        %that have each given type
        
        
% % %         id_indices_map   %containers.Map
% % %         %keys  - ids
% % %         %value - indices of the keys in the object
% % %         type_indices_map %containers.Map
% % %         %keys  - type_id
% % %         %value - cell array of indices with the given type
    end
    
    methods (Access = private)
        function obj = all_msg
            raw_string = mlintmex('-allmsg');
            
            %Step 1: Split into sections
            %---------------------------------------------------------------
            % NITS    ========== Aesthetics and Readability ==========
            % SEPEX  0   For better readability, use newline, semicolon, or comma before this statement.
            
            [temp,start_I,end_I] = regexp(raw_string,'^\s*(?<id>\w+)\s*=+ (?<type>[^=]+).*\n','names','start','end','lineanchors','dotexceptnewline');
            
            obj.type_id = {temp.id};
            obj.type_names = cellfun(@deblank,{temp.type},'un',0);
            
            %Step 2: Parse each section
            %--------------------------------------------------------------
            start_I_grab = end_I + 1;
            end_I_grab   = [start_I(2:end) length(raw_string)] - 1;
            
            n_sections      = length(start_I_grab);
            section_text    = cell(1,n_sections);
            textscan_output = cell(1,n_sections);
            entry_lengths   = zeros(1,n_sections);
            for iSection = 1:n_sections
                section_text{iSection} = raw_string(start_I_grab(iSection):end_I_grab(iSection));
                temp = textscan(section_text{iSection},'%s %f %[^\n]','MultipleDelimsAsOne',true);
                textscan_output{iSection} = temp;
                entry_lengths(iSection)   = length(temp{1});
            end
            
            %Consider regexp with scanning for the level or subtraction
            %to get the level ...
            
            fh = @(index) sl.cell.catSubElements(textscan_output,index,'dim',1);
            
            obj.ids    = fh(1);
            obj.levels = fh(2);
            obj.msgs   = fh(3);
            
            %Additional property population
            %--------------------------------------------------------------
            n_types = length(entry_lengths);
            obj.type_indices = sl.array.genFromCounts(entry_lengths,1:n_types);
            
            n_ids = length(obj.ids);
            obj.type_group_indices = sl.array.toCellArrayByCounts(1:n_ids,entry_lengths);
            
% %             obj.type_indices_map = containers.Map(obj.type_names,indices_of_each_type);
% %             obj.id_indices_map   = containers.Map(obj.ids,1:n_ids);
        end
    end
    
    methods (Static)
        function output = getInstance()
            
            persistent class_instance
            
            if isempty(class_instance)
                class_instance = mlintlib.all_msg;
            end
            output = class_instance;
        end
        function levels_output = getIDLevels(input_ids)
            %
            %   Returns the value of the .levels property for each
            %   input id.
            
            obj = mlintlib.all_msg.getInstance;
            [mask,loc] = ismember(input_ids,obj.ids);
            if ~all(mask)
                error('Not all input_ids matched')
            end
            
            levels_output = obj.levels(loc);
        end
    end
    
end

