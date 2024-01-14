function [Dofs] = GetDOFs(t, Geo, Dofs, Set)
	Dofs.Free   = true((Geo.numY)*2, 1);
	Dofs.Presc  = false((Geo.numY)*2,1);
	Dofs.Fix    = false((Geo.numY)*2,1);
	
	if strcmpi(Set.BC, 'compress') && t > Set.BCStart && t < Set.BCStop
		for c = 1:Geo.nCells
			Cell = Geo.Cells(c);
% 			prescIdxs = Cell.Y(:,1) <= Set.BCPrescribed;
			prescIdxs = Cell.Y(:,1) <= Set.BCPrescribed + (t-Set.BCStart)*Set.BCdxdt;

			fixIdxs = Cell.Y(:,1) >= Set.BCFix;

			% globalIds refers to reshaped arrays! and dofs are linear
			% indexes
			prescIds  = 2*Cell.globalIds(prescIdxs)-1; % this is only x component
			fixIds    = 2*Cell.globalIds(fixIdxs)-1; % this is only x component
			Dofs.Presc(prescIds)	= true;
			Dofs.Fix(fixIds)		= true;
			Dofs.Free(prescIds)		= false;
			Dofs.Free(fixIds)		= false;
        end
    elseif strcmpi(Set.BC, 'confinement')
	    Dofs.FixR = false(Geo.numY,1);
        for c = 1:Geo.nCells
			Cell = Geo.Cells(c);
            Y = Cell.Y;
            YIds = Cell.globalIds;
            FixR = vecnorm(Y, 2, 2) >= Set.confR;
    	    Dofs.FixR(YIds(FixR)) = true;
        end
	end
end