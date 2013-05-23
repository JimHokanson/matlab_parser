%Help

%Relevant classes:
%helpUtils.class2xml
%helpUtils.containers.ClassMemberHelpContainer <
%                           helpUtils.containers.atomicHelpContainer
%
%   Static Method:
%   helpUtils.containers.extractH1Line

%Constructor help:
%helpUtils.classInformation.fullConstructor.getHelp
%   create object by: helpUtils.splitClassInformation(class_name, '');
%
%Properties help:
%

topic            = 'NEURON.simulation';
classInfo        = helpUtils.splitClassInformation(topic, '', false);
classFilePath    = classInfo.minimizePath;
h                = helpUtils.containers.HelpContainerFactory.create(classFilePath);


%Class: helpUtils.containers.ClassMemberIterator
i1 = h.getSimpleElementIterator('properties');
% 'events'
% 'enumeration'
%
%
% 'methods'

%i1.hasNext  
%m = i1.next()  => helpUtils.containers.ClassMemberHelpContainer
%m.getHelp
%   => call to helpUtils.containers.atomicHelpContainer.getHelp()
%m.getH1


%==========================================================
%From:
% if ~isempty(this.classMetaData.SuperClasses)
%     supernode = dom.createElement('super-classes');
%     appendSuperClassNodes(this.classMetaData,supernode,dom);
%     classElt.appendChild(supernode);
% end
% 
% %---------------- setup constructor node-------------
% constructorIterator = this.helpContainer.getConstructorIterator();
% createConstructorNodeFuncHandle = @(~, constructorMeta, docNode)createConstructorNode(constructorMeta, docNode);
% this.appendClassMemberNodes(dom, classElt, constructorIterator, 'constructors', createConstructorNodeFuncHandle);
% 
% 
% %---------------- setup simple element nodes-------------
% appendSimpleElementNodes(this, dom, classElt, 'properties', @createPropertyNode);
% appendSimpleElementNodes(this, dom, classElt, 'events', @createEventNode);
% appendSimpleElementNodes(this, dom, classElt, 'enumeration', @createEnumerationNode);
% 
% %---------------- setup method nodes-------------
% methodIterator = this.helpContainer.getMethodIterator();
% this.appendClassMemberNodes(dom, classElt, methodIterator, 'methods', @createMethodNode);