function output = lex(filepath,varargin)
%
%   [output,raw] = mlintlib.lex(filepath,varargin)
%
%   OUTPUTS
%   =======================================================================
%   output : (struct)
%       .data : (struct)
%         ..line_numbers: [1x12443 double]
%         ..column_start_indices: [1x12443 double]
%         ..lengths: [1x12443 double]
%         ..types: {1x12443 cell}
%
%           IF 'resolve_indices' = true
%         ..absolute_start_indices: [1x12443 double]
%
%           IF 'get_unique_groups' = true
%         ..unique_types: {1x51 cell}
%         ..unique_indices_ca: {1x51 cell}
%
%       .raw: raw string output from the mex call
%
%           IF 'resolve_indices' = true
%       .newline_indices: [1 x n], Indices of newlines in the file.
%   
%   OPTIONAL INPUTS
%   =======================================================================
%   resolve_indices   : (default false)
%   get_unique_groups : (default false)
%   file_string       : (default '') for methods that require access to the
%           original string, this allows us to use the passed in string
%           instead of rereading the file from disk.

in.get_all           = false;
in.resolve_indices   = false;
in.get_unique_groups = false;
in.file_string       = '';
in = processVarargin(in,varargin);

%
if in.get_all
   in.resolve_indices   = true;
   in.get_unique_groups = true; 
end


%NOTE: The -m3 specifies not to return mlint messages
raw    = mlintmex(filepath,'-lex','-m3');

%Sample output of raw
%--------------------------------------------------------------------------
% 1868/13(2): IF:  IF
% 1868/16(7): <NAME>:  isempty
% 1868/23(1): '(':  '('
% 1868/24(14): <NAME>:  HDSManagedData
% 1868/38(1): '(':  '('



c = textscan(raw,'%f / %f ( %f ): %s %*[^\n]','MultipleDelimsAsOne',true);

%Tricky one: '':''
%[^''] - matches a character if it isn't a quote -> matches the colon
c{4} = regexp(c{4},'[^''][^:'']*','match','once');

data = struct(...
    'line_numbers',         c{1}',...
    'column_start_indices', c{2}',...
    'lengths',              c{3}',...
    'types',                {c{4}'});


%Index resolving
%==========================================================================
%To resolve indices we need to know where the new lines are, then from
%there, we add all line lengths to get final indices.
%
%PROBLEM
%------------------------------------------------
%
%       '...' removes the EOL character
%
%We have something like:
% a = { 1 2 3 ...
%     4 5 6 7 8 ...
%     9 10 11}
%
%   The EOL only shows up for the last line, so we have no idea
%   how long the first two lines are. This may not be critical for these 
%   entries but it might screw up subsequent lines

if in.resolve_indices
    if isempty(in.file_string)
        str = fileread(filepath);
    else
        str = in.file_string;
    end

    I_newline = strfind(str,sprintf('\n'));

    index_of_previous_line_end = [0 I_newline];

    absolute_start_indices = index_of_previous_line_end(data.line_numbers) ...
                            + data.column_start_indices;

    %Property Assignments
    %---------------------------------------------------------
    output.newline_indices = I_newline;                
    data.absolute_start_indices = absolute_start_indices;
end
                    

%Unique Group Handling
%==========================================================================
if in.get_unique_groups
    %TODO: Consider moving unique2 into local function or as part of
    %library
    [u_types,u_indices_ca] = unique2(data.types);

    %Property Assignments
    %-------------------------------------------------------------
    data.unique_types      = u_types;
    data.unique_indices_ca = u_indices_ca;

end
output.data = data;
output.raw  = raw;


end