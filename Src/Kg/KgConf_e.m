function [f,K]=KgConf_e(r, r0)
    x = r(1);
    y = r(2);
    rN = vecnorm(r);
    f  = (rN-r0)^2.*r./rN;

    K = 2.*[x^2 x*y; x*y y^2] + (rN-r0)/rN.*[y^2 -x*y; -x*y x^2];
    K = K.*(rN-r0)./rN^2;
end

