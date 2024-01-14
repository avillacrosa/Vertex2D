function [Q, K_Q] = boundQ(k, x_t, R, Geo, Mat, Set)
	Q  = speye(Geo.n_nodes*Geo.dim);
	K_Q = sparse(Geo.n_nodes*Geo.dim, Geo.n_nodes*Geo.dim);

    fixNodes = find(any(Geo.fixR(:,:,k), 2));
	for n = 1:length(fixNodes)
    	%% Fixed indexes and dimensions
    	DOF = 1:(Geo.dim-1);
    	fixNode = fixNodes(n);
    	idxs = (Geo.dim*(fixNode-1)+1):Geo.dim*fixNode;
	
    	%% Define factors appearing in target matrices
    	dx = (x_t(idxs(DOF), k)-Set.r0(DOF,k));
    	dz = -sqrt(Set.r^2-norm(dx).^2);
	
    	%% Define Target Matrices
    	Qn   = eye(Geo.dim, Geo.dim);
    	K_Qn = zeros(Geo.dim, Geo.dim);
	
    	%% Calculate factors for target matrices
    	q = -dx/dz;
		Qn(end, :) = [q', 0];

		%% MY IMPLEMENTATION
    	f = R(idxs);
		if Geo.dim == 2
			K_Qn = f(end)/(sqrt(Set.r^2-norm(dx).^2).^3)*...
				[Set.r^2 0
		     	0       0 ];
		elseif Geo.dim == 3
        	% f is wrong!
			K_Qn = f(end)/(sqrt(Set.r^2-norm(dx).^2).^3)*...
				[Set.r^2-norm(dx(2)).^2   prod(dx)   0
		     	prod(dx)  Set.r^2-norm(dx(1)).^2    0
			     	0        0       0];
		end
		
    	%% Assemble to global matrices
    	K_Q(idxs, idxs) = K_Qn;
    	Q(idxs, idxs) = Qn;
	end
end