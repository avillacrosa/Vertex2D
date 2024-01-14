function Geo = NewtonRaphson(Geo_0, Geo_n, Geo, Dofs, Set, K, g, numStep, t)
	
	dof = Dofs.Free;
	dy  = zeros((Geo.numY+Geo.nCells)*2, 1);
	dyr = norm(dy(dof)); gr=norm(g(dof));

	fprintf('Step: %i,Iter: %i ||gr||= %e ||dyr||= %e dt/dt0=%.3g\n',numStep,0,gr,dyr,Set.dt/Set.dt0);

	iter=1;
	while (gr>Set.tol || dyr>Set.tol) && iter<Set.MaxIter
		%% Compute coordinates
    	dy(dof)=-K(dof,dof)\g(dof);

    	%% Line search and update mechanical nodes
    	alpha = LineSearch(Geo_0, Geo_n, Geo, Dofs, Set, g, dy);
    	dy_reshaped = reshape(dy * alpha, 2, (Geo.numY+Geo.nCells))';
		
    	Geo = UpdateVertices(Geo, dy_reshaped);
		Geo = UpdateMeasures(Geo, Set);
    	%% Compute K, g
    	[g, K, E, gt, kt]=KgGlobal(Geo_0, Geo_n, Geo, Set);
%         PlotGeoF(Geo, gt.gE)
%         close all
		%% Check tolerances and if we are stuck?
    	dyr=norm(dy(dof)); gr=norm(g(dof));
    	fprintf('Step: % i,Iter: %i, Time: %g ||gr||= %.3e ||dyr||= %.3e alpha= %.3e  nu/nu0=%.3g \n',numStep,iter,t,gr,dyr,alpha,Set.nu/Set.nu0);
    	iter=iter+1;
	end
end

