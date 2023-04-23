function [Geo, Set] = InitGeoPBC(Geo, Set)
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
	nx = Geo.nx+3; 
	ny = Geo.ny+3;
	X = BuildTopo(nx,ny);

	%% Centre Nodal position at (0,0)
	X(:,1)=X(:,1)-mean(X(:,1));
	X(:,2)=X(:,2)-mean(X(:,2));

	%% Perform Delaunay
	% Define as ghost nodes those at the boundary
	XgID = X(:,1)==max(X(:,1)) | X(:,1)==min(X(:,1)) | X(:,2)==max(X(:,2)) | X(:,2)==min(X(:,2));

	Geo.nCells = size(X(~XgID,:),1);

	% Define PBC box
	maxX = max(X(~XgID,1));
	maxY = max(X(~XgID,2));
	Geo.BoxL = [2*maxX, 2*maxY];

	% Perform Triangulation
 	Twg = delaunay(X);

	%% Populate the Geo struct
	CellFields = ["X", "T", "Y", "Area", "Peri", "globalIds", "cglobalIds", "dividing", "polar", "YImage", "ghost"];

	% Build the Cells struct Array
	Geo.Cells = BuildStructArray(length(X), CellFields);

	for c = 1:length(X)
		Geo.Cells(c).X = X(c,:);
		Geo.Cells(c).T = Twg(any(ismember(Twg,c),2),:);
		Geo.Cells(c).dividing = false;
		Geo.Cells(c).polar = [0,0];
        Geo.Cells(c).ghost = XgID(c);
	end

	for c = 1:length(X)
		[Geo.Cells(c).Y,Geo.Cells(c).T] = BuildYFromX(Geo.Cells(c), Geo.Cells);
		Geo.Cells(c).YImage = zeros(size(Geo.Cells(c).Y));
	end

	% Apply periodic boundary conditions
	PlotGeo(Geo);
	Geo = BuildPBC(Geo);
	PlotGeo(Geo);
	%% CHECKS AND TESTS
	Geo = UpdateMeasures(Geo);
	Geo = BuildGlobalIds(Geo);
end