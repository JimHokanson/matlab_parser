classdef mcos_class < mparser
    %
    %   Class:
    %   mparser.mcos_class
    
    %{
    Testing code:
    
    %}
    
    properties
       parse_time
       comments
       props
       mthds
       super_classes %Not yet implemented
    end
    
    methods
        function obj = mcos_class(class_name)
           %
           %
           
           %? Add a test for class?
           obj.parse_time = now;
           
        end
    end
    
end

