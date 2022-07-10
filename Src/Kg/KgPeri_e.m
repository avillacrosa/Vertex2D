function [gl,Kl]=KgPeri_e(y1,y2)
	l = (y2-y1)';
	L = norm(l);
    dldy1 = -[1 0; 0 1];
    dldy2 = [1 0; 0 1];

    dLdy1 = dldy1'*l/L;
    dLdy2 = dldy2'*l/L;

    gl = [dLdy1; dLdy2]; % gl is already wrong

    Kl = [ dldy1*dldy1' dldy1*dldy2'
           dldy2*dldy1' dldy2*dldy2'];

    Kl = (Kl-gl*gl')/L;
end

