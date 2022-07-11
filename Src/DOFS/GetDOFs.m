function Dofs = GetDOFs(Geo, Dofs, Set)
	if ~exist('Dofs','var')
		Dofs = struct();
	end
	if strcmpi(Set.BC, 'compress')
		Dofs.PrescY = logical(Geo.numY+Geo.nCells);
		Dofs.Free   = logical(Geo.numY+Geo.nCells);
		for c = 1:Geo.nCells
			Cell = Geo.Cells(c);
			prescIdxs = Cell.Y(:,1) < Set.BCPrescribed;
			prescIds = Cell.globalIds(prescIdxs);
			Dofs.PrescY(prescIds) = true;
			Dofs.Free(prescIds)   = false;
		end
	end
	% TODO FIXME PLACEHOLDER
	Dofs.Free = 1:(Geo.numY)*2; 
end