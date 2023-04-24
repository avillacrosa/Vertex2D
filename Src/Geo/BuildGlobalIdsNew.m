function Geo = BuildGlobalIds(Geo)
	gIdsTot = 1;
    for ci = 1:Geo.nCells
		Cell = Geo.Cells(ci);
		gIds = zeros(length(Cell.Y), 1);
		for cj = 1:ci-1 
			ij		= [ci, cj];
			CellJ	= Geo.Cells(cj);
			
			face_ids_i = sum(ismember(Cell.T,ij),2)==2;
			face_ids_j = sum(ismember(CellJ.T,Cell.T(face_ids_i,:)),2)==3;

			gIds(face_ids_i) = CellJ.globalIds(face_ids_j);
		end
		nz = length(gIds(gIds==0));
		gIds(gIds==0) = gIdsTot:(gIdsTot+nz-1);
		Geo.Cells(ci).globalIds = gIds;
		gIdsTot = gIdsTot + nz;
    end
    Geo.numY = gIdsTot - 1;
	
	% Nodal ids are put after all the vertices ids and the Face Centres Ids
	% Therefore we need to add the total number of vertices and the total 
	% number of faces.
    for c = 1:Geo.nCells
		Geo.Cells(c).cglobalIds = c + Geo.numY ;
    end
end