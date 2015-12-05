%variable controling tradeoff betwen return and risk
gama=0.4;

%generate vector z (initial feasible point) - cumprir as restriçoes
%normalizar ou outra ideia
z=rand(50,1);
z=z/sum(z);
z=z(1:end-1);

%generate vector D 
D=eye(50,50);
D(end,:)=-1;
D(:,end)=0;
D=D(1:end,1:end-1);

%generate vector b
b=zeros(50,1);
b(50)=1;

% generate random expected returns of the assets
miu=randn(50,1);

%covariance matrix of the returns of assets in portfolio
temp=rand(50);
cov=temp'*temp;


% solve optimization problem
f0=(-miu'*(D*z+b)+gama*(D*z+b)'*cov*(D*z+b));

% %criacao de fi
% for i=1:49
%     fi(i)=-z(i)-b(i);
% end
% fi(50)= sum(z(1:49))-1;

% %criar phi
% phi=0;
% for i=1:50
%     phi=phi+log(-fi(i));
% end 
% phi=-phi;

%initial t, u and tolerance
t=1;
u=10;
epsb=0.05; %epsilon barrier # epsilon newthon

%loop1
while(1)


%newton method for convex functions
c1=10^-6;
beta=0.5;
epsn=0.001;
k=0;
%loop2
while(k<20)
    %calcular o gradiente à mao
    grad_fo=t*(-miu'*D+gama*(D*z+b)'*2*cov*D);
   
    %Actualização de fi e gradiente de fi e ainda PHI
    phi=0;
    for i=1:49
    fi(i,1)=-z(i)-b(i);
    grad_fi{i}=zeros(49,1);
    grad_fi{i}(i)=-1;
    phi=phi+log(-fi(i,1));
    end
    grad_fi{50}=ones(49,1);
    %grad_fi{50}(50)=0;
    fi(50)= sum(z(1:49))-1;
    phi=-phi-log(-fi(50));
    
    %gradiente PHI
    grad_phi=0;
    for i=1:50
    grad_phi=grad_phi+(1/-fi(i))*grad_fi{i};
    end
    %gradiente da função tfo+phi
    grad=grad_fo'+grad_phi;
    
    if(norm(grad)<epsn) 
        break;
    end
    
    %calculo da hessiana(a parte do phi)
    hess_phi=0;
    for i=1:50
    hess_phi=hess_phi+(1/(fi(i)^2))*grad_fi{i}*grad_fi{i}';
    end
    %calculo da heassiana(a parte de tfo)
    hess_fo=t*gama*2*(D'*cov*D);
    %hessiana da função tfo+phi
    hess=hess_fo+hess_phi;
    
    %descent direction
    d=hess\(-grad);
    
    alfa=1;
    z2=z+alfa*d;
    
    %novos fi 
    %PHI avaliado em z+alfa*d
    phi2=0;
    for i=1:49
    fi(i,1)=-z2(i)-b(i);    
    phi2=phi2+log(-fi(i));
    end 
    fi(50)=sum(z2(1:49))-1;
    phi2=-phi2-log(-fi(50));
    
    while((t*(-miu'*(D*z2+b)+gama*(D*z2+b)'*cov*(D*z2+b))+phi2)>((t*(-miu'*(D*z+b)+gama*(D*z+b)'*cov*(D*z+b))+phi)+alfa*c1*grad'*d))
        alfa=beta*alfa;
        z2=z+alfa*d;
        phi2=0;
        for i=1:49
        fi(i,1)=-z2(i)-b(i);    
        phi2=phi2+log(-fi(i));
        end 
        fi(50)=sum(z2(1:49))-1;
        phi2=-phi2-log(-fi(50));
     end
    
    z=z2;
    k=k+1;
end
    
if((50/t)<epsb) 
    break;
end
t=u*t;   
end 


% figure(1); clf; % plot solution
% subplot(1,3,1); stem(miu,'LineWidth',5);
% title('rates of return');
% subplot(1,3,2); stem(cov*w,'g','LineWidth',5);
% title('Risk');
% %figure(2); clf; 
% %subplot(1,1,1); stem(cov*w,'LineWidth',5);
% subplot(1,3,3); stem(w,'r','LineWidth',5);
% title('Portfolio');