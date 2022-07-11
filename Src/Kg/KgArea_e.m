function [gs,Ks]=KgArea_e(y1,y2,y3)
	Q = [ 0 1 ;-1 0];
	y1 = y1'; y2 = y2'; y3 = y3';
	a = y1-y3;
	b = y2-y3;
	q = a'*Q*b;
	dq1 = Q*(y2-y3); dq1 = dq1';
	dq2 = (y1-y3)'*Q; 
	dq3 = -(Q*(y2-y3))'-(y1-y3)'*Q;

	% OK UNTIL HERE
	At = norm(q)/2;
	dAdy = [q'*dq1'; q'*dq2'; q'*dq3']/(4*At);

	gs = dAdy;
	
	K_s1	= -(dAdy*dAdy')/At; % This is ok since gs is ok


	K_s2	=  [dq1'*dq1    dq1'*dq2    dq1'*dq3
				dq2'*dq1    dq2'*dq2    dq2'*dq3
				dq3'*dq1    dq3'*dq2    dq3'*dq3]; % THis is ok since gs is ok

	Q0 = zeros(size(Q));
% 	K_s3	=  [  Q0     q'*Q   -q'*Q
% 				q'*Q      Q0    -q'*Q
% 		       -q'*Q    -q'*Q     Q0];
	K_s3	=  -[  Q0     Q'*q    Q'*q
				-Q'*q     Q0     Q'*q
		        -Q'*q   -Q'*q     Q0];
	
	Ks		= K_s1 + (K_s2 + K_s3)/(4*At);
% 	Ks		= K_s1 + (K_s2)/(4*At);
end

