%{

M - main method in an mfile
S - function or method - applies to methods in a classdef file as well


            %M  - method
            %N  - nested
            %S  - sub
            %U  - called functions
            %A? - anonymous function
            %E? - end of function
            %
            %   NOTE: E may be empty for anonymous functions ...
            %
            %# - nesting
            
            %-callops
            %==========================================================================
            %   This seems to ignore calls to methods of classes
            %
            %   C1 - ????
            %   C2 - line number
            %   C3 - column
            %   C4 - function call
            %

            %
            %S0 - start of function
            %E0 - end of function
            %U1 - 
            
%             
%             U1 229 21 sprintf
%             U1 229 68 class
%             U1 234 16 length
%             U1 236 20 isvalid
%             U1 239 54 uint32
%             U1 248 31 fieldnames
%             U1 249 39 cellfun
%             A1 249 47 
%             E1 249 76 
%             A1 252 40 
%             E1 252 93 
%             U1 255 38 cell
%             U1 259 31 end

    FROM FDEP:
    % - description .SUB().n
%------------------------------------------------------------
	desc.s={
		1	'U'	'functions outside the scope'
		2	'S'	'subfunctions'
		3	'N'	'nested functions'
		4	'A'	'anonymous functions'
		5	'UD'	'user defined functions'
		6	'MS'	'ML stock functions'
		7	'MB'	'ML built-in functions'
		8	'CE'	'calls to eval..'
		9	'MC'	'ML classes'
		10	'OC'	'other classes'
		11	'TB'	'ML tbx'
		12	'X'	'unresolved calls'
	};
%
% - description .CALL{x,n}
%-------------------------------------------------------
	desc.c={
		1	'UD'	'user defined functions'
		2	'MS'	'ML stock functions'
		3	'MB'	'ML built-in functions'
		4	'MC'	'ML classes'
		5	'OC'	'other classes'
		6	'TB'	'ML tbx'



%}