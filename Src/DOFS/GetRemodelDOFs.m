function [Dofs, Geo] = GetRemodelDOFs(Tnew, Dofs, Geo)
	remodelDofs = zeros(0,1);
	Dofs.Free = false((Geo.numY+Geo.nCells)*2,1);
	% TODO FIXME, Overwriting here...
	for c = 1:Geo.nCells
		tetlocalIds = all(ismember(Geo.Cells(c).T, Tnew),2);
		gIdsRemodel = Geo.Cells(c).globalIds(tetlocalIds);%assuming that they are at the end...
		remodelDofs(end+1:end+length(gIdsRemodel),:) = gIdsRemodel;
		for gid = 1:length(gIdsRemodel)
			dofIds = (2*gIdsRemodel(gid)-1):2*gIdsRemodel(gid);
			Dofs.Free(dofIds) = true;
		end
	end
	Geo.AssemblegIds  = unique(unique(remodelDofs, 'rows'));
end