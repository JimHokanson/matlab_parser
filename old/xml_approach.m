if false
    opts.evalCode = false;
    opts.format = 'html';
end

h = which('regex_tools.findCommentPattern');
h = which('NEURON.simulation.extracellular_stim');

tic
originalCode = fileread(h);

code = regexprep(originalCode,'\r\n?','\n');
newLine = sprintf('\n');
 
% Trim trailing whitespace.
code = regexprep(code,'[ \t]+(\n|$)','\n');
 
% Exactly one newline at the end of the file.
code = regexprep(code,'(.)\n*$','$1\n');


dom = com.mathworks.xml.XMLUtils.createDocument('mscript');
dom.getDocumentElement.setAttribute('xmlns:mwsh', ...
    'http://www.mathworks.com/namespace/mcode/v1/syntaxhighlight.dtd')
frag = com.mathworks.publishparser.PublishParser.getDomFragment( ...
        dom, ...
        code,...
        0, ...
        0);
dom.getDocumentElement.appendChild(frag);

temp  = dom.getElementsByTagName('mcode-xmlized');
temp2 = temp.item(0);
temp3 = temp2.item(0);

%temp3.item(15).getNodeName
%mwsh:comments

nEntries = temp3.getLength;

span_lengths = zeros(1,nEntries);
real_lengths = zeros(1,nEntries);
span_types   = zeros(1,nEntries);
span_name    = cell(1,nEntries);
str          = cell(1,nEntries);

tic
for iEntry = 1:nEntries
   span_lengths(iEntry) = temp3.item(iEntry-1).getLength;
   span_types(iEntry)   = temp3.item(iEntry-1).getNodeType;
   span_name{iEntry}    = char(temp3.item(iEntry-1).getNodeName);
   
   real_lengths(iEntry) = temp3.item(iEntry-1).getTextContent.length;
   
   str{iEntry}          = char(temp3.item(iEntry-1).getTextContent);
end
toc

% % % % node_name = cell(1,nEntries);
% % % % 
% % % % tic
% % % % for iChild = 0:nEntries -1
% % % %    node_name{iChild+1} = char(temp3.item(iChild).getNodeName); 
% % % % end
% % % % toc
% % % % 
% % % % tic
% % % % for iChild = 0:nEntries -1
% % % %    node_name{iChild+1} = temp3.item(iChild).getNodeName; 
% % % % end
% % % % toc
% % % % tic
% % % % wtf = cellfun(@char,node_name,'un',0);
% % % % toc
% % % % 
% % % % %??What about groupings?????
% % % % %=> if other objects are inbetween - NO
% % % % %=> How are block comments handled?
% % % % I_comment       = find(strcmp(node_name,'mwsh:comments'));
% % % % 
% % % % nComments = length(I_comment);
% % % % comment_strings = cell(1,nComments);
% % % % for iC = 1:nComments
% % % %    comment_strings{iC} = char(temp3.item(I_comment(iC)-1).getTextContent); 
% % % % end
% % % % 
% % % % I_keyword       = find(strcmp(node_name,'mwsh:keywords'));
% % % % 
% % % % nKeywords       = length(I_keyword);
% % % % keyword_strings = cell(1,nKeywords);
% % % % for iK = 1:nKeywords
% % % %    keyword_strings{iK} = char(temp3.item(I_keyword(iK)-1).getTextContent);  
% % % % end
% % % % %'...'    'end'    'for'    'function'    'if'    'persistent'
% % % % 
% % % % I_text          = find(strcmp(node_name,'#text'));
% % % % nTexts = length(I_text);
% % % % text_strings = cell(1,nTexts);
% % % % for iT = 1:nTexts
% % % %    text_strings{iT} = char(temp3.item(I_text(iT)-1).getTextContent);  
% % % % end
% % % % 
% % % % toc

%Extract Comments

%Unique node names
%--------------------------------------------------------------------------
%'#text'    'mwsh:comments'    'mwsh:keywords'    'mwsh:strings'

%temp3.item()

% str = xmlwrite(temp2);

%mwsh:code
%mwsh:keywords

%mcode-xmlized