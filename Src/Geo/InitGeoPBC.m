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
	% Also remove first column and row of real cells for PBC
	XgID((nx+2):(nx+2+Geo.nx)) = true;
	for ji = 2:(ny-1)
		idx = (ji-1)*nx+2;
		XgID(idx)=true;
	end

	Geo.nCells = size(X(~XgID,:),1);
	% Reorder by putting ghost nodes at the end
	X = [X(~XgID,:); X(XgID,:)];
	Geo.XgID = true(length(XgID));
	Geo.XgID(1:size(find(~XgID))) = false;
	% Define PBC
	
	maxX = max(X(~Geo.XgID,1));
	maxY = max(X(~Geo.XgID,2));
	Geo.BoxL = [2*maxX, 2*maxY];
	X = X-Geo.BoxL/100;

	% Perform Triangulation
 	Twg = delaunay(X);

	%% Populate the Geo struct
	CellFields = ["X", "T", "Y", "Area", "Peri", "globalIds", "cglobalIds", "dividing", "polar", "YImage"];

	% Build the Cells struct Array
	Geo.Cells = BuildStructArray(length(X), CellFields);

	for c = 1:length(X)
		Geo.Cells(c).X = X(c,:);
		Geo.Cells(c).T = Twg(any(ismember(Twg,c),2),:);
		Geo.Cells(c).dividing = false;
		Geo.Cells(c).polar = [0,0];
	end

	for c = 1:Geo.nCells
		[Geo.Cells(c).Y,Geo.Cells(c).T] = BuildYFromX(Geo.Cells(c), Geo.Cells);
		Geo.Cells(c).YImage = zeros(size(Geo.Cells(c).Y));
	end

	% Apply periodic boundary conditions
	for c = 1:Geo.nCells
		Ys = Geo.Cells(c).Y;
		YsIm = zeros(size(Ys));

		top   = Ys(:,2) > +Geo.BoxL(2)/2;
		Ys(top,2) = Ys(top,2) - Geo.BoxL(2);
		YsIm(top,2) = -1;

		bot   = Ys(:,2) < -Geo.BoxL(2)/2;
		Ys(bot,2) = Ys(bot,2) + Geo.BoxL(2);
		YsIm(top,2) = +1;

		right = Ys(:,1) > +Geo.BoxL(1)/2;
		Ys(right,1) = Ys(right,1) - Geo.BoxL(1);
		YsIm(right,1) = -1;

		left  = Ys(:,1) < -Geo.BoxL(1)/2;
		Ys(left,1) = Ys(left,1) + Geo.BoxL(1);
		YsIm(left,1) = +1;

		Geo.Cells(c).YImage = YsIm;
		Geo.Cells(c).Y = Ys;
	end

	% Remove ghost cells
	ghostCells = find(Geo.XgID);
	for ci = 1:length(ghostCells)
		gh = ghostCells(ci);
		Geo.Cells(gh) = [];
		ghostCells = ghostCells - 1;
	end

	% Restore connectivities
	for c = 1:Geo.nCells
		% Get opposite cells by indexing!
		
	end

	Geo = UpdateMeasures(Geo);
	Geo = BuildGlobalIds(Geo);
end