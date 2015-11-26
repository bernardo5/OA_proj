%reescrever o problema com aquelas eqs, pag2
m=50;
%variable controling tradeoff betwen return and risk
gama=0.4;

%generate vector z (initial feasible point) - cumprir as restriçoes
%normalizar ou outra ideia
z=rand(m,1);
z=z/sum(z);

%generate vector D 
D=eye(m,m);
D(end,:)=-1;
D(:,end)=0;

%generate vector b
b=zeros(m,1);
b(m)=1;

% generate random expected returns of the assets
miu=randn(m,1);

%covariance matrix of the returns of assets in portfolio
temp=rand(m);
cov=temp'*temp;

%epsilon barrier # epsilon newthon

% solve optimization problem
f0=(-miu'*(D*z+b)+gama*(D*z+b)'*cov*(Dz+b));



for i=1:(m-1)
    fi(i)=-z(i)-b(i);
end

fi(m)=sum(z(1:(m-1)))-1;


%phi=-sum(log(-fi(i,:)), i=1..50);
phi=0;
for i=1:m
    phi=phi+log(-fi(i));
end 
phi=-phi;




%initial t, u and tolerance
t=1;
u=10;
e=0.05;

%loop1
while(1)
    


%newton method for convex functions
c1=10.^-6;
beta=0.5;
g=ones(1,1);
k=1;
%loop2
    %calcular o gradiente à mao
    g(k,1)=gradient(t*f0+phi)
    
if((m/t)<e)
    break;
end
t=t*u;
end

figure(1); clf; % plot solution
subplot(1,3,1); stem(miu,'LineWidth',5);
title('rates of return');
subplot(1,3,2); stem(cov*w,'g','LineWidth',5);
title('Risk');
%figure(2); clf; 
%subplot(1,1,1); stem(cov*w,'LineWidth',5);
subplot(1,3,3); stem(w,'r','LineWidth',5);
title('Portfolio');