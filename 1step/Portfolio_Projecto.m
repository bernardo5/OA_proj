% uses package CVX from http://cvxr.com/cvx

n=4;
%generate vector of ones
vec_ones=ones(n,1);

% generate random expected returns of the assets
miu=rand(n,1);

%covariance matrix of the returns of assets in portfolio
temp=rand(n);
cov=temp'*temp;

%gama - variable controling tradeoff betwen return and risk

gama=0:0.1:1; %equivalent as gama=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9]
i=1;
while i<=10
    % solve optimization problem
    cvx_begin
    variable w(n);

    maximize(miu'*w - gama(i)*w'*cov*w);

    subject to
    (vec_ones')*w == 1; w>=0;
    cvx_end;

    figure(1); %clf; % plot solution
    hold on;
    subplot(1,3,1); stem(miu,'LineWidth',5);
    title('rates of return');
    hold on;
    subplot(1,3,2); stem(w,'r','LineWidth',5);
    title('portfolio');
    hold on;
    subplot(1,3,3); stem(gama(i)*w'*cov*w,'r','LineWidth',5);
    title('risk');
    
    i=i+1;
end