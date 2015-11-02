% uses package CVX from http://cvxr.com/cvx

%variable controling tradeoff betwen return and risk
gama=0.4;

%generate vector of ones
vec_ones=ones(4,1);

% generate random expected returns of the assets
miu=rand(4,1);

%covariance matrix of the returns of assets in portfolio
temp=rand(4);
cov=temp'*temp;

% solve optimization problem
cvx_begin
variable w(4);

maximize(miu'*w - gama*w'*cov*w);

subject to
(vec_ones')*w == 1; w>=0;
cvx_end;

figure(1); clf; % plot solution
subplot(1,2,1); stem(miu,'LineWidth',5);
title('rates of return');
subplot(1,2,2); stem(w,'r','LineWidth',5);
title('portfolio');