function [output,raw] = edit(filepath)
%
%
%   [output,raw] = mlintlib.edit(filepath)
%

%     line_number: '809'
%            name: 'classes'
%               n: '808'
%            type: 'V'
%            rest: ''

%NOTE: This function is not yet finished ...


raw    = mlintmex(filepath,'-edit');

%1                  HDS   0 C  AllProp Handle DyProp Class
output = regexp(raw,'^ *(?<line_number>\d+) *(?<name>[\w_\d]*) *(?<n>\d+) (?<type>\w) *(?<rest>.*)','names','lineanchors','dotexceptnewline');

end