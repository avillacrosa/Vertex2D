function [Geo_0, Geo_n, Geo] = T1transition(Geo_0, Geo_n, Geo, Dofs, Set)
	for c = 1:Geo.nCells
		Ys = Geo.Cells(c).Y;
		Ts = Geo.Cells(c).T;
		for yi = 1:size(Ys,1)
			if yi+1 > size(Ys,1)
    			y1 = Ys(1,:); 
    			y2 = Ys(size(Ys,1),:);
				nY = [1, size(Ys,1)];

			else
    			y1 = Ys(yi,:);
    			y2 = Ys(yi+1,:);
    			nY = [yi, yi+1];
			end
			l = norm(y2-y1);

			if l < Set.RemodelTol
				oldTets = Ts(nY,:);
% 				if any(oldTets(:) > Geo.nCells)
% % 					fprintf("2-2 flip involves a ghost node. Not implemented\n")
% 					% continue
%                     % 1
% 				end
				connNodes = setxor(oldTets(1,:), oldTets(2,:));
				dissNodes = intersect(oldTets(1,:), oldTets(2,:));
				newTets = [connNodes dissNodes(1); connNodes dissNodes(2)];

				%% Update vertices
				Geo		= ReplaceYs(oldTets, newTets, Geo);
				Geo_n	= ReplaceYs(oldTets, newTets, Geo_n);

				%% Update Geo
	        	Geo   = BuildGlobalIds(Geo); 
				Geo_n = BuildGlobalIds(Geo_n);
	
				Geo   = UpdateMeasures(Geo,Set);
				Geo_n = UpdateMeasures(Geo_n,Set);

				%% Reset Geo_0 because of remodelling?
				Geo_0 = Geo;

				%% Solve local problem
				[DofsRemodel, Geo] = GetRemodelDOFs(newTets, Dofs, Geo);
				Geo.Remodelling = true;
				Set.nu = 50*Set.nu0*2;
				while Set.nu ~= Set.nu0
					% TODO FIXME, is there a cleaner way for this?
					Set.nu = max(Set.nu/2, Set.nu0);
					[g, K, ~] = KgGlobal(Geo_0, Geo_n, Geo, Set, DofsRemodel);
					Geo = NewtonRaphson(Geo_0, Geo_n, Geo, DofsRemodel, Set, K, g, -1, -1);
				end
				Geo.Remodelling = false;
			end
		end
	end
end