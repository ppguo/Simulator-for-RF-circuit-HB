function hb_test(filename)
%% initialize the parameters
parser_init;
cparse_init;
%% parse the netlist
[LINELEM,NLNELEM,INFO,NODES,LINNAME,NLNNAME,PRINTNV,PRINTBV,PRINTBI,PLOTNV,PLOTBV,PLOTBI] = parser(filename);
%% Get basic parameters
Base_Tone = INFO(length(INFO)-2);
k = INFO(length(INFO))-1;
T = 1/Base_Tone;
n = 2*k+1;
dt = T/n;
lin_size = size(LINELEM,1);
%% generate sin signals for all V_SIN
sin_list = generate_sin_signal_list(LINELEM,dt,n);

%% start TR to provide initial parameters for HB
Nmax = 10;  % max iteration num
num = n;  % n time points we need to solve
num_circuit_variable = TR_matrix_size(LINELEM,NLNELEM,NODES); 
output = zeros(num_circuit_variable,n);
output(1,1) = 3; % choose suitable initial value for TR
epi = 1e-10;
all_output_withoutC = [];
node_len= length(NODES);
for i=2:num+1
    %% Set previous state as Initial Guess 
    if(i>1)
        output(:,i)=output(:,i-1); 
    end

    %% Get initial value of F and Jaco function
    [F,J,I,new_row_list,nonC_list]=TR_dynamic_stamp(sin_list(:,i-1),output(:,i),output(:,i-1),dt,LINELEM,NLNELEM,INFO,NODES);
    iteration=0;
    %% start iteration (Solve Jx=I)
    while((norm(F)>epi)&&(iteration<Nmax))    
        [F,J,I,new_row_list,nonC_list]=TR_dynamic_stamp(sin_list(:,i-1),output(:,i),output(:,i-1),dt,LINELEM,NLNELEM,INFO,NODES);
        output(:,i)=output(:,i)-J\F;
        iteration=iteration+1;
    end
    
    %% We only keep the non-Capcitor part for HB (Capcitor in TR need a new line,HB doesn't,To be updated)
    tmp_output = output(1:node_len,i)';
    nonC_length = length(nonC_list);
    for m = 1:nonC_length
        tmp_output(m+node_len) = output(new_row_list(nonC_list(m)),i);
        new_row_list(nonC_list(m)) = m + node_len;
    end
    all_output_withoutC = [all_output_withoutC,tmp_output]; %For Diff MNA of TR and HB
end


%% stamp matrix for HB
%% Y:linear part of Jacobian matrix(C and R)
%% NY:Nonlinear part of Jacobian(MOSFET, etc)
n = hb_matrix_size(LINELEM,NODES);
[Y,I]=hb_linear_stamper(LINELEM,NLNELEM,new_row_list,n,k,Base_Tone);
Xn = all_output_withoutC';
[NM,NI] = hb_nonlinear_stamper(NLNELEM,n,k,Xn);
DFTmtx = gen_DFTmtx(n,k);  %FFT matrix
IDFTmtx = gen_IDFTmtx(n,k); %IFFT matrix
NY = DFTmtx*NM*IDFTmtx;

%% start HB iteration
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

%% a simple plot(to be updated)
node1 = [];
node2 = [];
for m = 1:(2*k+1)
    node1(m) = Xn(PLOTNV(1)+(m-1)*n);
    node2(m) = Xn(PLOTNV(2)+(m-1)*n);
end
x = (1:2*k+1);
plot(x,node1,x,node2)
legend('node1','node2')
title(filename)