function Dofs = GetDOFs(Geo, Dofs, Set)
	Dofs.Presc  = false((Geo.numY)*2,1);
	Dofs.Free   = true((Geo.numY)*2, 1);
	Dofs.Fix = false((Geo.numY)*2,1);
	
	if strcmpi(Set.BC, 'compress')
		for c = 1:Geo.nCells
			Cell = Geo.Cells(c);
			prescIdxs = Cell.Y(:,1) < Set.BCPrescribed;
			% globalIds refers to reshaped arrays! and dofs are linear
			% indexes
			prescIds  = 2*Cell.globalIds(prescIdxs)-1; % this is only x component
			Dofs.Presc(prescIds) = true;
			Dofs.Free(prescIds)   = false;
		end
	end
	Dofs.Free = find(Dofs.Free); 
end