%variable controling tradeoff betwen return and risk
gama=0.1;

entries = 4;

%generate vector z (initial feasible point) - cumprir as restri�oes
%normalizar ou outra ideia
z=rand(entries,1);
z=z/sum(z);
z=z(1:end-1);

%generate vector D 
D=eye(entries,entries);
D(end,:)=-1;
D(:,end)=0;
D=D(1:end,1:end-1);

%generate vector b
b=zeros(entries,1);
b(entries)=1;

% generate random expected returns of the assets
%miu=rand(entries,1);
miu=[0.25;0.25;0.25;0.25];

%covariance matrix of the returns of assets in portfolio
% temp=rand(entries);
% cov=temp'*temp;

%cov=[100 5 0.500000000000000 0.500000000000000;5 0.5 0.500000000000000 0.500000000000000;0.500000000000000 0.500000000000000 1 0.500000000000000;0.500000000000000 0.500000000000000 0.500000000000000 1];
cov=[100 5 0.500000000000000 0.500000000000000;5 0.500000000000000 0.500000000000000 0.500000000000000;0.500000000000000 0.500000000000000 10 0.500000000000000;0.500000000000000 0.500000000000000 0.500000000000000 10];

% %CVX solver
% tic
cvx_w=cvx_output(entries, miu, cov, gama);
% toc

%initial t, u and tolerance
t=1;
u=10;
epsb=0.05;


%BARRIER METHOD
%LOOP BARRIER
tic
while(1)
    
    %METODO DE NEWTON
    
    c1=10^-6;
    beta=0.5;
    epsn=0.001;
    k=0;
    
    %K NUNCA PASSA DAS 10-20 ITERA�OES NO NEWTON
    while(k<20)
        
        %CALCULO DE F0, FI E PHI
        fo = calc_fo(miu, gama, cov, z, D, b);
        fi = calc_fi(z, b, entries);
        phi = calc_phi(fi, entries);
        
        %CALCULO DOS RESPECTIVOS GRADIENTES
        grad_fo = calc_grad_fo(miu, gama, cov, z, D, b);
        grad_fi = calc_grad_fi(fi, entries);
        grad_phi = calc_grad_phi(fi, grad_fi, entries);
        
        %CALCULO DO GRADIENTE DA FUN�AO tF0+PHI
        grad = t*grad_fo'+grad_phi;
        
        %CONDI��O DE PARAGEM DO NEWTON
        if(norm(grad)<epsn) 
            break;
        end
        
        %CALCULO DAS HESSIANAS DE F0 E PHI
        hess_fo = calc_hess_fo(gama, cov, D);
        hess_phi = calc_hess_phi(z, entries);
        
        %HESSIANA DA FUN��O t*F0+PHI
        hess = t*hess_fo + hess_phi;
        
        %CALCULO DE Dk
        d = hess\(-grad);
        
        alfa = 1;
        
        %WHILE DO NEWTON COM ARMIJO RULE
        while((t*calc_fo(miu, gama, cov, z+alfa*d, D, b) + calc_phi(calc_fi(z+alfa*d, b, entries), entries))>((t*fo+phi)+alfa*c1*grad'*d))
            
            %ACTUALIZA��O DE ALFA
            alfa = beta*alfa;
            
        end
            
        %ACTUALIZA��O DE Z
        z = z + alfa*d;        
        
        k = k + 1;
        
    end
    
    %CONDI�AO DE PARAGEM DO BARRIER
    if(entries/t < epsb)
        break;
    end
    
    %ACUTALIZA�AO DO t
    t = u*t;
    
end

z(entries)=1-sum(z);

    %figure; %clf; % plot solution
    %hold on;
    %subplot(1,3,1); stem(miu,'LineWidth',5);
    %title('rates of return');
    %hold on;
    subplot(1,3,2); stem(z,'g','LineWidth',5);
    title('portfolio');
    hold on;
    subplot(1,3,3); stem(gama*cov*z,'g','LineWidth',5);
    title('risk');
    hold on;

toc