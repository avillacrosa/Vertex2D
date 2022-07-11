function [gl,Kl]=KgLine_e(y1,y2)
	l = (y2-y1)';
    dldy1 = -[1 0; 0 1];
    dldy2 = [1 0; 0 1];

    gl = [ dldy1'*l; dldy2'*l]; % gl is already wrong
	
    Kl = [ dldy1*dldy1' dldy1*dldy2'
           dldy2*dldy1' dldy2*dldy2'];
end

