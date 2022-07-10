function [real_node,new_node_list] = get_real_node(node_list,node)
    len = length(node_list);
    new_node_list = node_list;
    if node=='0'
        real_node=-1;
        return;
    end
    for i=1:len
        if node_list(i)==str2num(node)
            real_node=i;
            return
        end
    end
    real_node = len+1;
    new_node_list(len+1) = str2num(node);
end
    
    