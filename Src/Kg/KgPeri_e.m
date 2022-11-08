function [gl,Kl]=KgPeri_e(y1,y2)
	l = (y2-y1)';
	L = norm(l);
    dldy1 = -[1 0; 0 1];
    dldy2 = [1 0; 0 1];

    gl = [dldy1'*l; dldy2'*l]/L;

    Kl = [ dldy1*dldy1' dldy1*dldy2'
           dldy2*dldy1' dldy2*dldy2'];

    Kl = (Kl-gl*gl')/L;
end

