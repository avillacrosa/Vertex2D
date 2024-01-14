
function x_t = updateDirichlet(k, x_t, R, Geo, Mat, Set)
	fixNodes = find(any(Geo.fixR(:,:,k), 2));
    for n = 1:length(fixNodes)
	    DOF = 1:(Geo.dim-1);
	    FIX = Geo.dim;
	    fixNode = fixNodes(n);
	    idxs = (Geo.dim*(fixNode-1)+1):Geo.dim*fixNode;
	    dx = x_t(idxs(DOF), k)-Set.r0(DOF,k);
	    dz = -sqrt(Set.r^2-norm(dx).^2);
	    x_t(idxs(FIX),k) = (dz+Set.r0(FIX,k));
    end
end


function Geo = updateDOFs(k, x_t, Geo, Mat, Set)
	if Set.nano
		if k-1 > 0
        	load_cond = (Set.r0(end, k) - Set.r0(end, k-1))<0;
		else
        	load_cond = (Set.r0(end,k) - 0)>0;
		end
		fixR = false(Geo.n_nodes, Geo.dim);
		if load_cond % LOADING
			if k-1 > 0
				x_kv = ref_nvec(x_t(:,k-1), Geo.n_nodes, Geo.dim);
				fixR(:,end) = vecnorm(x_kv-Set.r0(:,k)', 2, 2)<Set.r;
			else
				x_kv = ref_nvec(vec_nvec(Geo.X), Geo.n_nodes, Geo.dim);
				fixR(:,end) = vecnorm(x_kv-Set.r0(:,k)', 2, 2)<Set.r;
			end
		else
			fixR = Geo.fixR(:,:,k);
		end
		Geo.fixR(:,:,k)			= fixR;
		Geo.fix(logical(fixR))	= true;
		Geo.dof					= not(Geo.fix);
    	if Set.r0(end,k) == min(Set.r0(end,:)) && k == Set.time_incr/2
        	Geo.fixR(:,:,(k+1):end) = flip(Geo.fixR(:,:,1:k), 3);
    	end
	end
end