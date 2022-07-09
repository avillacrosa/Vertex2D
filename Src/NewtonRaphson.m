function [Geo, g, K, E, Set, gr, dyr, dy] = NewtonRaphson(Geo_0, Geo_n, Geo, Dofs, Set, K, g, numStep, t)
	
	dof = Dofs.Free;
	dy  = zeros((Geo.numY+Geo.nCells)*2, 1);
	dyr = norm(dy(dof)); gr=norm(g(dof));
	gr0 = gr;

	fprintf('Step: %i,Iter: %i ||gr||= %e ||dyr||= %e dt/dt0=%.3g\n',numStep,0,gr,dyr,Set.dt/Set.dt0);

	E = 0;
    
	Set.iter=1;
    auxgr=zeros(3,1);
    auxgr(1)=gr;
	ig = 1;
	while (gr>Set.tol || dyr>Set.tol) && Set.iter<Set.MaxIter
		%% Compute coordinates
    	dy(dof)=-K(dof,dof)\g(dof);

    	%% Line search and update mechanical nodes
    	alpha = LineSearch(Geo_0, Geo_n, Geo, Dofs, Set, g, dy);
%         alpha = 1;
    	dy_reshaped = reshape(dy * alpha, 2, (Geo.numY+Geo.nCells))';

    	Geo = UpdateVertices(Geo, dy_reshaped);
        PostProcessingVTK(Geo, Set, Set.iter);

		Geo = UpdateMeasures(Geo);

    	%% Compute K, g
    	[g,K,E]=KgGlobal(Geo_0, Geo_n, Geo, Set);

		%% Check tolerances and if we are stuck?
    	dyr=norm(dy(dof)); gr=norm(g(dof));
    	fprintf('Step: % i,Iter: %i, Time: %g ||gr||= %.3e ||dyr||= %.3e alpha= %.3e  nu/nu0=%.3g \n',numStep,Set.iter,t,gr,dyr,alpha,Set.nu/Set.nu0);
		Geo.Cells(1).Peri
    	Set.iter=Set.iter+1;
	end
end

