function [ELEM_list,INFO,NODES,NAMES,PRINTNV,PRINTBV_OLD,PRINTBI_OLD,PLOTNV,PLOTBV_OLD,PLOTBI_OLD] = cparse(filename);

% filename='dbmixer.hb';
fid = fopen(filename,'r');
NODES=[];
ELEM_list = [];
NAMES = [];
PRINTNV = [];
PLOTNV = [];
PRINTBV_OLD = [];
PLOTBV_OLD = [];
PRINTBI_OLD = [];
PLOTBI_OLD = [];
INFO = [];
while ~feof(fid)
    line=fgetl(fid);
    line=lower(strtrim(line));  %改为小写字母，并去头尾的空格
    if((size(line,2)>2)&(~(line(1)=='*')&~(line(1)=='.')|(line(1:2))=='.m'))   %跳过空白和注释
        [line,num] = sentence_parser(line);
        [ELEM,NODES,NAMES]= sentence_to_elem(line,num,NODES,NAMES);
        if length(ELEM)>0, ELEM_list(size(ELEM_list,1)+1,1:length(ELEM)) = ELEM; end % to be updated
    elseif ((size(line,2)>5)&(line(1)=='.'))
        [line,num] = sentence_parser(line);
        [PRINTNV,PRINTBV_OLD,PRINTBI_OLD,PLOTNV,PLOTBV_OLD,PLOTBI_OLD,INFO] = sentence_to_print(PRINTNV,PRINTBV_OLD,PRINTBI_OLD,PLOTNV,PLOTBV_OLD,PLOTBI_OLD,line,num,NODES,NAMES,INFO);
    end
end

% PRINTNV = [];
% PLOTNV = [];
% PRINTBV = [];
% PLOTBV = [];
% PRINTBI = [];
% PLOTBI = [];
% 
% fclose(fid);
% fid = fopen(filename,'r');
% while ~feof(fid)
%     line=fgetl(fid);
%     line=lower(strtrim(line));  %改为小写字母，并去头尾的空格
%     if((size(line,2)>2)&(line(1)=='.'))   %处理打印信息
%         [line,num] = sentence_parser(line)
%         [ELEM,NODES,NAMES]= sentence_to_elem(line,num,NODES,NAMES);
%         if length(ELEM)>0, ELEM_list(size(ELEM_list,1)+1,1:length(ELEM)) = ELEM; end % to be updated
%     end
% end






    