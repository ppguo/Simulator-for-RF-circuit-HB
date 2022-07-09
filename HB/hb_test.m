parser_init;
cparse_init;
global HB_BASETONE_ HB_FREQNUM_ V_
[LINELEM,NLNELEM,INFO,NODES,LINNAME,NLNNAME,PRINTNV,PRINTBV,PRINTBI,PLOTNV,PLOTBV,PLOTBI] = parser('dbmixer.hb')
Base_Tone = INFO(length(INFO)-4);
k = INFO(length(INFO)-3)-1;
T = 1/Base_Tone;
n = 2*k+1;
dt = T/n;
lin_size = size(LINELEM,1);
sin_list = zeros(1,n);
for i = 1:lin_size
    tmp_D = LINELEM(i,:);
    if tmp_D(TYPE_)==V_
        if tmp_D(5)==0,
        else
            tmp_D;
            sin_list(i,:) = generate_sin_signal(tmp_D,dt,n);
        end
    end
end

Nmax = 10;
num = n;
num_circuit_variable = TR_matrix_size(LINELEM,NLNELEM,NODES);
output = zeros(num_circuit_variable,n);
output(1,1) = 3;%initial value for TR
epi = 1e-10;
all_output_withoutC = [];
node_len= length(NODES);
for i=2:num+1
     % Set Initial Guess
    if(i>1)
        output(:,i)=output(:,i-1); 
    end

     % Get initial value of F and Jaco function
    [F,J,I,new_row_list,nonC_list]=stamper_test(sin_list(:,i-1),output(:,i),output(:,i-1),dt,LINELEM,NLNELEM,INFO,NODES);
    iteration=0;
     % start iteration
    while((norm(F)>epi)&&(iteration<Nmax))    
        [F,J,I,new_row_list,nonC_list]=stamper_test(sin_list(:,i-1),output(:,i),output(:,i-1),dt,LINELEM,NLNELEM,INFO,NODES);
        norm(I);
        output(:,i)=output(:,i)-J\F;
        iteration=iteration+1;
    end
    tmp_output = output(1:node_len,i)';
    nonC_length = length(nonC_list);
    for m = 1:nonC_length
        tmp_output(m+node_len) = output(new_row_list(nonC_list(m)),i);
        new_row_list(nonC_list(m)) = m + node_len;
    end
    all_output_withoutC = [all_output_withoutC,tmp_output]; %For Diff MNA of TR and HB
end


%stamp matrix for HB
% test_vector = [3,0,0,0,0,0,0,0,0,0,0,0,0];
% [J,I,new_row_list]=stamper_test_without_C(sin_t(1),test_vector,test_vector,dt);
% n = length(I);
n = hb_matrix_size(LINELEM,NODES);
[Y,I]=hb_linear_stamper(LINELEM,NLNELEM,new_row_list,n,k,Base_Tone);
Xn = all_output_withoutC';
[NM,NI] = hb_nonlinear_stamper(NLNELEM,n,k,Xn);
size(NM);
NM(1:n,1:n);
DFTmtx = gen_DFTmtx(n,k);
IDFTmtx = gen_IDFTmtx(n,k);
NY = DFTmtx*NM*IDFTmtx;

%start HB iteration
Xn_F = DFTmtx * Xn;
F = DFTmtx * NI + Y*Xn_F-I;
iteration = 0;
Nmax = 100;
epi = 1e-10;
norm(F);
while((norm(F)>epi)&&(iteration<Nmax))
    Xn_F=Xn_F-(Y+NY)\F;
    Xn = IDFTmtx*Xn_F;
    [NM,NI] = hb_nonlinear_stamper(NLNELEM,n,k,Xn);
    NY = DFTmtx*NM*IDFTmtx;
    F = DFTmtx * NI + Y*Xn_F-I;
    iteration=iteration+1
end

%% a simple plot
%% to be updated
output = [];
input = [];
for m = 1:(2*k+1)
    output(m) = Xn(PLOTNV(1)+(m-1)*n);
    input(m) = Xn(PLOTNV(2)+(m-1)*n);
end
x = (1:2*k+1);
plot(x,output,x,input)
legend('output','input')
title('Buffer test')