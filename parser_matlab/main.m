cparse_init;
parser_init;

filename='dbmixer.hb';
fid = fopen(filename,'r');

while ~feof(fid)
    line=fgetl(fid);
    line=lower(strtrim(line));  %改为小写字母，并去头尾的空格
    node_list=[];
    if((size(line,2)>0)&&~(line(1)=='*'))   %跳过空白和注释
        [line,num] = sentence_parser(line);
        [ELEM,node_list]= sentence_to_elem(line,num,node_list);
        
    end
end

    