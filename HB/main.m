%% get_input_signal
parser_init;
cparse_init;
[LINELEM,NLNELEM,INFO,NODES,LINNAME,NLNNAME,PRINTNV,PRINTBV,PRINTBI,PLOTNV,PLOTBV,PLOTBI] = parser('demo_inv.ckt');

dt = 1e-10;
lin_size = size(LINELEM,1);
for i = 1:lin_size
    tmp_D = LINELEM(i,:);
    switch(tmp_D(TYPE_))
        case{V_},
        if tmp_D(5)==2
            Vin=get_input_signal(tmp_D,dt);
        end
    end
end

Nmax = 100;
num = length(Vin);
output = zeros(11,num+1);
 output(:,1) = [3,0,0,3,3,3,0,0,0,0,0];
%  [F,J]=stamper_test(Vin(i-1),output(:,1),output(:,1),dt);
epi = 1e-10;
for i=2:num+1
     % Set Initial Guess
    if(i>1)
        output(:,i)=output(:,i-1); 
    end

     % Get initial value of F and Jaco function
    [F,J,I]=stamper_test(Vin(i-1),output(:,i),output(:,i-1),dt);       
    iteration=0;
     % start iteration
     i
    while((norm(F)>epi)&&(iteration<Nmax))    
        [F,J,I]=stamper_test(Vin(i-1),output(:,i),output(:,i-1),dt)
        norm(I)
        output(:,i)=output(:,i)-J\F;
        iteration=iteration+1;
    end
end
output
