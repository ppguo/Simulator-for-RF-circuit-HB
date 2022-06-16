parser_init;
cparse_init;
global HB_BASETONE_ HB_FREQNUM_
[LINELEM,NLNELEM,INFO,NODES,LINNAME,NLNNAME,PRINTNV,PRINTBV,PRINTBI,PLOTNV,PLOTBV,PLOTBI] = parser('buffer.hb')
Base_Tone = INFO(length(INFO)-4)
k = INFO(length(INFO)-3)-1
T = 1/Base_Tone
dt = T/(2*k+1)
SRC = LINELEM(2,:)
sin_t = generate_sin_signal(SRC,dt,T)


Nmax = 100;
num = length(sin_t);
output = zeros(16,num+1);
%
%  [F,J]=stamper_test(Vin(i-1),output(:,1),output(:,1),dt);
output(:,1) = [3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
% epi = 1e-10;
% for i=2:num+1
%      % Set Initial Guess
%     if(i>1)
%         output(:,i)=output(:,i-1); 
%     end
% 
%      % Get initial value of F and Jaco function
%     [F,J,I]=stamper_test(sin_t(i-1),output(:,i),output(:,i-1),dt);       
%     iteration=0;
%      % start iteration
%     while((norm(F)>epi)&&(iteration<Nmax))    
%         [F,J,I]=stamper_test(sin_t(i-1),output(:,i),output(:,i-1),dt);
%         norm(I)
%         output(:,i)=output(:,i)-J\F;
%         iteration=iteration+1;
%     end
% end
test_vector = [3,0,0,0,0,0,0,0,0,0,0,0,0];
[J,I,new_row_list]=stamper_test_without_C(sin_t(1),test_vector,test_vector,dt); 
n = length(I);
[Y,I]=hb_linear_stamper(LINELEM,new_row_list,n,k,Base_Tone*2*pi);
Xn = ones((2*k+1)*n,1);
[NM,NI] = hb_nonlinear_stamper(NLNELEM,n,k,Xn);
size(NM);
NM(1:n,1:n);
DFTmtx = gen_DFTmtx(n,k);
IDFTmtx = gen_IDFTmtx(n,k);
NY = DFTmtx*NM*IDFTmtx;
% while ()
%     [NL] = hb_nonlinear_i_stamper()
%     update J
%     update V
%     update v
% end
Xn_F = DFTmtx * Xn;
F = DFTmtx * NI + Y*Xn_F-I;
iteration = 0;
Nmax = 100;
epi = 1e-10;
norm(F)
while((norm(F)>epi)&&(iteration<Nmax))
    Xn_F=Xn_F-(Y+NY)\F;
    Xn = IDFTmtx*Xn_F;
    [NM,NI] = hb_nonlinear_stamper(NLNELEM,n,k,Xn);
    F = DFTmtx * NI + Y*Xn_F-I;
    iteration=iteration+1;
end
Xn(1:n)