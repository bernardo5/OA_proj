% uses package CVX from http://cvxr.com/cvx
tic

n=4;
%generate vector of ones
vec_ones=ones(n,1);

% generate random expected returns of the assets
%miu=rand(n,1);
% miu=[0.602843089382083;0.711215780433683;0.221746734017240;0.117417650855806];
miu=[0.1;0.3;0.3;0.3];
%covariance matrix of the returns of assets in portfolio
temp=rand(n);
cov=temp'*temp;

cov(1,1)=100000;
cov(1,2)=100;
cov(2,1)=100;
% temp=[0.296675873218327 0.0855157970900440 0.928854139478045 0.237283579771521;0.318778301925882 0.262482234698333 0.730330862855453 0.458848828179931;0.424166759713807 0.801014622769739 0.488608973803579 0.963088539286913;0.507858284661118 0.0292202775621463 0.578525061023439 0.546805718738968];
% cov=temp'*temp;


%gama - variable controling tradeoff betwen return and risk

%gama=0:0.1:1; %equivalent as gama=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9]
i=1;
gama=100;
%while i<=10
    % solve optimization problem
    cvx_begin
    variable w(n);

    maximize(miu'*w - gama*w'*cov*w);

    subject to
    (vec_ones')*w == 1; w>=0;
    cvx_end;

    figure; %clf; % plot solution
    hold on;
    subplot(1,3,1); stem(miu,'LineWidth',5);
    title('rates of return');
    hold on;
    subplot(1,3,2); stem(w,'r','LineWidth',5);
    title('portfolio');
    hold on;
    subplot(1,3,3); stem(cov*w,'r','LineWidth',5);
    title('risk');
    
    i=i+1;
%end
toc