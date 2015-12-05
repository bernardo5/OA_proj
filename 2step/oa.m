tic

%variable controling tradeoff betwen return and risk
gama=0.4;

entries = 50;

%generate vector z (initial feasible point) - cumprir as restriçoes
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
miu=randn(entries,1);
%miu=[0.602843089382083;0.711215780433683;0.221746734017240;0.117417650855806];

%covariance matrix of the returns of assets in portfolio
temp=rand(entries);
cov=temp'*temp;

%temp=[0.296675873218327 0.0855157970900440 0.928854139478045 0.237283579771521;0.318778301925882 0.262482234698333 0.730330862855453 0.458848828179931;0.424166759713807 0.801014622769739 0.488608973803579 0.963088539286913;0.507858284661118 0.0292202775621463 0.578525061023439 0.546805718738968];
%cov=temp'*temp;

%initial t, u and tolerance
t=1;
u=10;
epsb=0.05;


%BARRIER METHOD
%LOOP BARRIER

while(1)
    
    %METODO DE NEWTON
    
    c1=10^-6;
    beta=0.5;
    epsn=0.001;
    k=0;
    
    %K NUNCA PASSA DAS 10-20 ITERAÇOES NO NEWTON
    while(k<20)
        
        %CALCULO DE F0, FI E PHI
        fo = calc_fo(miu, gama, cov, z, D, b);
        fi = calc_fi(z, b, entries);
        phi = calc_phi(fi, entries);
        
        %CALCULO DOS RESPECTIVOS GRADIENTES
        grad_fo = calc_grad_fo(miu, gama, cov, z, D, b);
        grad_fi = calc_grad_fi(fi, entries);
        grad_phi = calc_grad_phi(fi, grad_fi, entries);
        
        %CALCULO DO GRADIENTE DA FUNÇAO tF0+PHI
        grad = t*grad_fo'+grad_phi;
        
        %CONDIÇÃO DE PARAGEM DO NEWTON
        if(norm(grad)<epsn) 
            break;
        end
        
        %CALCULO DAS HESSIANAS DE F0 E PHI
        hess_fo = calc_hess_fo(gama, cov, D);
        hess_phi = calc_hess_phi(z, entries);
        
        %HESSIANA DA FUNÇÃO t*F0+PHI
        hess = t*hess_fo + hess_phi;
        
        %CALCULO DE Dk
        d = hess\(-grad);
        
        alfa = 1;
        
        %WHILE DO NEWTON COM ARMIJO RULE
        while((t*calc_fo(miu, gama, cov, z+alfa*d, D, b) + calc_phi(calc_fi(z+alfa*d, b, entries), entries))>((t*fo+phi)+alfa*c1*grad'*d))
            
            %ACTUALIZAÇÃO DE ALFA
            alfa = beta*alfa;
            
        end
            
        %ACTUALIZAÇÃO DE Z
        z = z + alfa*d;        
        
        k = k + 1;
        
    end
    
    %CONDIÇAO DE PARAGEM DO BARRIER
    if(entries/t < epsb)
        break;
    end
    
    %ACUTALIZAÇAO DO t
    t = u*t;
    
end

%z(entries)=1-z;

toc