classdef editc < handle_light
    %
    %   Class:
    %   mlintlib.edit
    
    properties
    end
    
    properties
       raw_mex_output 
    end
    
    methods
        function obj = editc(file_path)
            
           obj.raw_mex_output = mlintmex(file_path,'-edit','-m3');
           
           %   C1 - seems useless, other than for display and parse checking
%   C2 - name of the thing we are looking at
%   C3 - ???? 
%   C4 - C (class) V (Value) F (Function) E (Error)
%
%   0               <VOID>  -1 E 
%   1                  HDS   0 C  AllProp Handle DyProp Class
%   2         dynamicprops   0 C  Base Class
%   3               objIds   1 V  Property Set/Priv Get/Pub
%   4                zeros   1 F  Amb

c = textscan(obj.raw_mex_output,'%f %s %f %s %[^\n]');

keyboard
        
           
           
        end
    end
    
end

