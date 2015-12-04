%reescrever o problema com aquelas eqs, pag2
entries=50;
%variable controling tradeoff betwen return and risk
gama=0.4;

z=init_z(entries);

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

%covariance matrix of the returns of assets in portfolio
temp=rand(entries);
cov=temp'*temp;

%CVX solver
tic
cvx_w=cvx_output(entries, miu, cov, gama );
toc
% solve optimization problem
f0=  f_zero ( miu, D, z, b, gama, cov );

%initial t, u and tolerance
t=1;
u=10;
epsb=0.05; %epsilon barrier # epsilon newthon
tic
%loop1
while(1)


%newton method for convex functions
c1=10^-6;
beta=0.5;
epsn=0.001;
k=0;
%loop2
while(k<20)
    %calcular o gradiente � mao
    grad_fo=grad_f_zero( t, miu, D, gama, b, z, cov );
   
    %Actualiza��o de fi e gradiente de fi e ainda PHI
    phi=0;
    for i=1:entries-1
    fi(i,1)=-z(i)-b(i);%
    grad_fi{i}=zeros(entries-1,1);
    grad_fi{i}(i)=-1;
    phi=phi+Real_log(-fi(i,1));
    end
    grad_fi{50}=ones(entries-1,1);
    fi(entries)= sum(z(1:entries-1))-1;%
    phi=-phi-Real_log(-fi(entries));
    
    %gradiente PHI
    grad_phi=0;
    for i=1:entries
    grad_phi=grad_phi+(1/-fi(i))*grad_fi{i};
    end
    %gradiente da fun��o tfo+phi
    grad=grad_fo'+grad_phi;
    
    if(norm(grad)<epsn) 
        break;
    end
    
    %calculo da hessiana(a parte do phi)
   hess_phi= hessiana_phi( z, entries );

    %calculo da heassiana(a parte de tfo)
    hess_fo=t*gama*2*(D'*cov*D);
    %hessiana da fun��o tfo+phi
    hess=hess_fo+hess_phi;
    
    
    
    
    %descent direction
    d=hess\(-grad);
    
    alfa=1;
    
    while(function_to_minimize( t, miu, D, z+alfa*d, b, gama, cov, calc_phi( get_fi( z+alfa*d, entries ) ) )> Armijo( t, miu, D, z, b, gama, cov, phi, alfa, c1, grad, d))
        alfa=beta*alfa;
     end
    
    z=z+alfa*d;
    k=k+1;
end
    
if((entries/t)<epsb) 
    break;
end
t=u*t;   
end 
toc

% figure(1); clf; % plot solution
% subplot(1,3,1); stem(miu,'LineWidth',5);
% title('rates of return');
% subplot(1,3,2); stem(cov*w,'g','LineWidth',5);
% title('Risk');
% %figure(2); clf; 
% %subplot(1,1,1); stem(cov*w,'LineWidth',5);
% subplot(1,3,3); stem(w,'r','LineWidth',5);
% title('Portfolio');