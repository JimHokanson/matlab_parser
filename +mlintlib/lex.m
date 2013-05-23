function [output,raw] = lex(filepath)
%
%   [output,raw] = mlintlib.lex(filepath)
%
%   OUTPUTS
%   ==============================================
%   output : (struct)
%            data_line_number: [1x12443 double]
%     data_column_start_index: [1x12443 double]
%                 data_length: [1x12443 double]
%                   data_type: {1x12443 cell}

raw    = mlintmex(filepath,'-lex','-m3');

% 1868/13(2): IF:  IF
% 1868/16(7): <NAME>:  isempty
% 1868/23(1): '(':  '('
% 1868/24(14): <NAME>:  HDSManagedData
% 1868/38(1): '(':  '('


c = textscan(raw,'%f / %f ( %f ): %s %*[^\n]','MultipleDelimsAsOne',true);

%Tricky one: '':''
%[^''] - matches a character if it isn't a quote -> matches the colon
c{4} = regexp(c{4},'[^''][^:'']*','match','once');

output = struct('data_line_number',c{1}','data_column_start_index',...
            c{2}','data_length',c{3}','data_type',{c{4}'});

%OLD CODE
%=========================================================
% % % line_string    = '(?<line_start>\d+)';
% % % col_start      = '(?<col_start>\d+)';
% % % content_length = '(?<content_length>\d+)';
% % % content_type   = '''?(?<content_type>[^''][^:'']+)''?';
% % % %content_data   = '(?<content_data>.*)';
% % % 
% % % 
% % % 
% % % 
% % % pattern = ['^[ ]*' line_string '/[ ]*' col_start '\(' content_length '\): *' content_type]; % ':  ' content_data];
% % % 
% % % 
% % % 
% % % temp = regexp(raw,pattern,'lineanchors','names','dotexceptnewline');
% % % 
% % % line_starts  = str2double({temp.line_start});
% % % col_starts   = str2double({temp.col_start});
% % % data_length  = str2double({temp.content_length});
% % % 
% % % % line_starts  = str2int({temp.line_start});
% % % % col_starts   = str2int({temp.col_start});
% % % % data_length  = str2int({temp.content_length});
% % % 
% % % output2 = struct('data_line_number',line_starts,'data_column_start_index',...
% % %             col_starts,'data_length',data_length,'data_type',{{temp.content_type}});
% % % % expected_data_lengths = str2double({temp.content_length});
% % % % observed_data_lengths = arrayfun(@(x) length(x.content_data),temp);
% % % 
% % % 
% % % %?? - handle grabbing strings a different way???
% % % %?? - split into lines, then grab
% % % 
% % % %output = regexp(raw,'^[ ]*(?<line_start>\d+)/[ ]*(?<col_start>\d+)\(\(<content_length>\d+)\)','lineanchors');

end

% function int_out = fastPositiveStringToInteger(s1)
% 
%     lt = length(s1);
%     int_out = (double(s1)-48)*(((10*ones(1,lt)).^(lt-1:-1:0))');
% 
% end