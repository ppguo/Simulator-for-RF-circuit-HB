%sentence_parser
%to split the sentence into elements
function [line,num] = sentence_parser(line_in)
line_in = strtrim(line_in);
line = strsplit(line_in,{' ','\t'});
num = size(line,2);
end