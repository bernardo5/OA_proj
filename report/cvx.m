cvx_begin
    variable w(number_of_entries);

    maximize(miu'*w - gama*w'*cov*w);

    subject to
    (vec_ones')*w == 1; w>=0;
 cvx_end;