function [ELEM,node_list,NAMES]=sentence_to_elem(line,num,node_list,NAMES)
    global TYPE_ MAG_ VALUE_ PHASE_ IC_ DAC_ N1_ N2_ CN1_ CN2_ FNUM_
    global MOS_MID_ MOS_W_ MOS_L_ MOS_ND_ MOS_NG_ MOS_NS_ MOS_TYPE_
    global MOD_ID_ MOD_VT_ MOD_MU_ MOD_COX_ MOD_LAMBDA_ MOD_CJ0_
    global M_MID_
    global R_ M_ Y_ N_ C_ L_ S_ K_ W_ V_ I_ G_ E_ F_ H_
    global DC_ AC_ PWL_ SIN_
    global SIN_DC_ SIN_AC_ SIN_FREQ_ SIN_PHASE_
    global NMOS_ PMOS_
    name = line{1};
    ELEM = [];
    if (name(1)=='r')
        NAMES(size(NAMES,1)+1,1:length(name)) = name;
        ELEM(TYPE_) = R_;
        [N1,node_list] = get_real_node(node_list,line{2});
        [N2,node_list] = get_real_node(node_list,line{3});
        ELEM(N1_) = N1;
        ELEM(N2_) = N2;
        ELEM(VALUE_)=str2num(line{4});
    elseif (name(1)=='c')
        NAMES(size(NAMES,1)+1,1:length(name)) = name;
        ELEM(TYPE_) = C_;
        [N1,node_list] = get_real_node(node_list,line{2});
        [N2,node_list] = get_real_node(node_list,line{3});
        ELEM(N1_) = N1;
        ELEM(N2_) = N2;
        ELEM(VALUE_)=str2num(line{4});
    elseif (name(1)=='l')
        NAMES(size(NAMES,1)+1,1:length(name)) = name;
        ELEM(TYPE_) = L_;
        [N1,node_list] = get_real_node(node_list,line{2});
        [N2,node_list] = get_real_node(node_list,line{3});
        ELEM(N1_) = N1;
        ELEM(N2_) = N2;
        ELEM(VALUE_)=str2num(line{4});
    elseif (name(1)=='v')
        NAMES(size(NAMES,1)+1,1:length(name)) = name;
        ELEM(TYPE_) = V_;
        [N1,node_list] = get_real_node(node_list,line{2});
        [N2,node_list] = get_real_node(node_list,line{3});
        ELEM(N1_) = N1;
        ELEM(N2_) = N2;
       %PWL to be added
        if line{4}(1:2)=='dc'
            ELEM(DAC_)=DC_;
            ELEM(VALUE_)=str2num(line{5});
        elseif line{4}(1:3)=='sin'
            ELEM(DAC_)=SIN_;
            ELEM(SIN_DC_)=str2num(line{5});
            ELEM(SIN_AC_)=str2num(line{6});
            ELEM(SIN_FREQ_)=str2num(line{7});
            ELEM(SIN_PHASE_)=str2num(line{8});
        end
    elseif (name(1)=='m')
        NAMES(size(NAMES,1)+1,1:length(name)) = name;
        ELEM(TYPE_) = M_;
        ELEM(MOS_MID_) = str2num(line{8});
        ELEM(MOS_W_) = str2num(line{6});
        ELEM(MOS_L_) = str2num(line{7});
        [ND,node_list] = get_real_node(node_list,line{2});
        [NG,node_list] = get_real_node(node_list,line{3});
        [NS,node_list] = get_real_node(node_list,line{4});
        ELEM(5) = ND;  %%%WHY WHY WHY???
        ELEM(6) = NG;
        ELEM(7) = NS;
        if line{5}=='n'
            ELEM(MOS_TYPE_) = NMOS_;
        else
            ELEM(MOS_TYPE_) = PMOS_;
        end
     elseif (length(name)>=6 & (name(1:6)=='.model'))
        ELEM(TYPE_)='.';
        ELEM(MOD_ID_)=str2num(line{2});
        ELEM(MOD_VT_)=str2num(line{4});
        ELEM(MOD_MU_)=str2num(line{6});
        ELEM(MOD_COX_)=str2num(line{8});
        ELEM(MOD_LAMBDA_)=str2num(line{10});
        ELEM(MOD_CJ0_)=str2num(line{12});
    end
end

        
        
        
    
