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
    
	[X, XgID] = BuildTopo(Geo, Set);
	%% Perform Delaunay
	% Define as ghost nodes those at the boundary
% 	XgID = X(:,1)==max(X(:,1)) | X(:,1)==min(X(:,1)) | X(:,2)==max(X(:,2)) | X(:,2)==min(X(:,2));
	Geo.nCells = size(X(~XgID,:),1);
	if strcmpi(Set.BC, 'periodic')
		% Define PBC box
		maxX = max(X(~XgID,1)); maxY = max(X(~XgID,2));
		Geo.BoxL = [2*maxX, 2*maxY];
		Geo.XgID = [];
	end
	% Perform Triangulation
 	Twg = delaunay(X);

	%% Populate the Geo struct
	CellFields = ["X", "T", "Y", "Area", "Peri", "globalIds", "cglobalIds", "dividing", "polar"];

	% Build the Cells struct Array
	Geo.Cells = BuildStructArray(length(X), CellFields);

	for c = 1:length(X)
		Geo.Cells(c).X = X(c,:);
		Geo.Cells(c).T = Twg(any(ismember(Twg,c),2),:);
		Geo.Cells(c).dividing = false;
		Geo.Cells(c).polar = [0,0];
		Geo.Cells(c).ghost = XgID(c);
    end
%     f = figure();
%     hold on
%     for c = 1:length(X)
%         Xplot = Geo.Cells(c).X;
%         if XgID(c)
%             plot(Xplot(:,1), Xplot(:,2), 'o')
%         else
%             plot(Xplot(:,1), Xplot(:,2), 'x')
%         end
%     end
	for c = 1:length(X)
		[Geo.Cells(c).Y,Geo.Cells(c).T] = BuildYFromX(Geo.Cells(c), Geo.Cells);
		Geo.Cells(c).YImage = zeros(size(Geo.Cells(c).Y));
	end

	if strcmpi(Set.BC,'periodic')
		cellOrder = zeros(Geo.nx*Geo.ny,1);
		for ji = 3:(nx-1)
			start = nx*(ji-1)+3;
			slice = ((ji-3)*Geo.nx+1):((ji-3)*Geo.nx+Geo.ny);
			cellOrder(slice)=start:(start+Geo.nx-1);
		end
		Geo = BuildPBC(Geo, cellOrder);
	else
		cellOrder = [find(~XgID); find(XgID)];
	end
	Geo = ReorderCells(Geo, cellOrder);
	Geo.XgID = (Geo.nCells+1):length(Geo.Cells);
	Geo = UpdateMeasures(Geo, Set);
	Geo = BuildGlobalIds(Geo);
end