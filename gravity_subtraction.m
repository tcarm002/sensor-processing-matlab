function acc_g = gravity_subtraction(acc, acc_mean, q)
    acc_g = zeros(size(acc));
    for i = 1:length(acc)
        a_temp = [0 acc(i,:)];
        a_temp = quatmultiply(quatmultiply(q(i,:),a_temp),quatconj(q(i,:)));
        acc_g(i,:) = a_temp(2:4) - acc_mean;
    end
end