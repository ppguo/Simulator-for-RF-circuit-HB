function [PRINTNV_OLD,PRINTBV_OLD,PRINTBI_OLD,PLOTNV_OLD,PLOTBV_OLD,PLOTBI_OLD,INFO] = sentence_to_print(PRINTNV_OLD,PRINTBV_OLD,PRINTBI_OLD,PLOTNV_OLD,PLOTBV_OLD,PLOTBI_OLD,line,num,NODES,NAMES,INFO);
    name = line{1};
    if length(name)>=8
        if name(1:8)=='.printnv'
            for i=2:num
                for j=1:length(NODES)
                    if (str2num(line{i})==NODES(j))
                        PRINTNV_OLD(length(PRINTNV_OLD)+i-1) = j;
                    end
                end
            end
%          if name(1:8)=='.PRINTBV' TO Be done
        end
    elseif length(name)>=7
        if name(1:7)=='.plotnv'
            for i=2:num
                for j=1:length(NODES)
                    if (str2num(line{i})==NODES(j))
                        PLOTNV_OLD(length(PLOTNV_OLD)+i-1) = j;
                    end
                end
            end
        end
    elseif name(1:3)=='.hb'
        for i=2:num
            INFO(length(INFO)+i-1) = str2num(line{i});
        end
    end
end
             
        
        