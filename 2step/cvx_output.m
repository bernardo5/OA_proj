function [ w ] = cvx_output( number_of_entries, miu, cov, gama )
% uses package CVX from http://cvxr.com/cvx


%generate vector of ones
vec_ones=ones(number_of_entries,1);

%gama - variable controling tradeoff betwen return and risk

%gama=0:0.1:1; %equivalent as gama=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9]
i=1;
%while i<=10
    % solve optimization problem
    cvx_begin
    variable w(number_of_entries);

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
    subplot(1,3,3); stem(cov*w,'g','LineWidth',5);
    title('risk');
    hold on;
    
   % i=i+1;
%end


end
