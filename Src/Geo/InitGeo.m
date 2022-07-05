function [Geo, Set] = InitGeo(Geo, Set)
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% InitializeGeometry3DVertex:										  
	%   Builds the Geo base struct for the simple geometries / examples.  
	%   After this, Geo should include an array struct (Cells), each with 
	%   its nodal position (X), vertexs position (Y), globalIds used in   
	%   the calculation of K and g and Faces (another array struct).      
	% Input:															  
	%   Geo : Geo struct with only nx, ny and nz							  
	%   Set : User input set struct										  
	% Output:															  
	%   Geo : Completed Geo struct										  
	%   Set : User input set struct with added default fields             
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	%% Build nodal mesh 
	X = BuildTopo(Geo.nx, Geo.ny);

	%% Centre Nodal position at (0,0)
	X(:,1)=X(:,1)-mean(X(:,1));
	X(:,2)=X(:,2)-mean(X(:,2));

	%% Perform Delaunay
	Twg = delaunay(X);
	% Define as ghost nodes those at the boundary
	% TODO FIXME ;(
	Geo.XgID = X(:,1)==max(X(:,1)) | X(:,1)==min(X(:,1)) | X(:,2)==max(X(:,2)) | X(:,2)==min(X(:,2));
	Geo.nCells = size(X(~Geo.XgID,:),1);
	
	X = [X(~Geo.XgID,:); X(Geo.XgID,:)];
	idxs = 1:size(X, 1);
	idxs(Geo.XgID) = Geo.nCells+1:size(X,1);
	idxs(~Geo.XgID) = 1:Geo.nCells;
% 	Geo.XgID = (1:size(X(Geo.XgID,:),1))+size(X(~Geo.XgID,:),1);

 	Twg = idxs(Twg);

	%% Populate the Geo struct
	CellFields = ["X", "T", "Y", "Area", "Area0", "Peri", "Peri0", "globalIds", "cglobalIds"];

	% Build the Cells struct Array
	Geo.Cells = BuildStructArray(length(X), CellFields);

	for c = 1:length(X)
		Geo.Cells(c).X = X(c,:);
		Geo.Cells(c).T = Twg(any(ismember(Twg,c),2),:);
	end

	for c = 1:Geo.nCells
		Geo.Cells(c).Y         = BuildYFromX(Geo.Cells(c), Geo.Cells);
	end
	Geo = BuildGlobalIds(Geo);
end