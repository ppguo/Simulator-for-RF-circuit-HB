function [ELEM,node_list]=sentence_to_elem(line,num,node_list)
    global TYPE_ MAG_ VALUE_ PHASE_ IC_ DAC_ N1_ N2_ CN1_ CN2_ FNUM_
    global MOS_MID_ MOS_W_ MOS_L_ MOS_N1_ MOS_N2_ MOS_N3_ MOS_TYPE_
    global MOD_ID_ MOD_VT_ MOD_MU_ MOD_COX_ MOD_LAMBDA_ MOD_CJ0_
    global M_MID_
    global R_ M_ Y_ N_ C_ L_ S_ K_ W_ V_ I_ G_ E_ F_ H_
    
    name = line{1};
    ELEM = [];
    
    if (name(1)=='r')
        ELEM(TYPE_) = R_;
        [N1,node_list] = get_real_node(node_list,line{2});
        [N2,node_list] = get_real_node(node_list,line{3});
        ELEM(N1_) = N1;
        ELEM(N2_) = N2;
        ELEM(VALUE_)=str2num(line{4});
    elseif (name(1)=='c')
        ELEM(TYPE_) = C_;
        [N1,node_list] = get_real_node(node_list,line{2});
        [N2,node_list] = get_real_node(node_list,line{3});
        ELEM(CN1_) = N1;
        ELEM(CN2_) = N2;
        ELEM(VALUE_)=str2num(line{4});
    elseif (name(1)=='l')
        ELEM(TYPE_) = L_;
        [N1,node_list] = get_real_node(node_list,line{2});
        [N2,node_list] = get_real_node(node_list,line{3});
        ELEM(N1_) = N1;
        ELEM(N2_) = N2;
        ELEM(VALUE_)=str2num(line{4});
        
        
        
    