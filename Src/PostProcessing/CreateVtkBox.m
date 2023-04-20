function CreateVtkBox(Geo_0, Geo, Set, Step)
	%% ============================= INITIATE =============================
	str0=Set.OutputFolder;                          % First Name of the file 
	fileExtension='.vtk';                            % extension
	
	newSubFolder = fullfile(pwd, str0, 'Box');
	if ~exist(newSubFolder, 'dir')
    	mkdir(newSubFolder);
	end
	nameout=fullfile(newSubFolder, ['Box', fileExtension]);
	fout=fopen(nameout,'w');
	header = "# vtk DataFile Version 3.98\n";
	header = header + "Delaunay_vtk\n";
	header = header + "ASCII\n";
	header = header + "DATASET UNSTRUCTURED_GRID\n";
	box = Set.Box;
	bl = [-box/2,-box/2];
	br = [+box/2,-box/2];
	tr = [+box/2,+box/2];
	tl = [-box/2,+box/2];
	points = "";
	points = points + sprintf(" %.8f %.8f %.8f\n", bl(1), bl(2), 0);
	points = points + sprintf(" %.8f %.8f %.8f\n", br(1), br(2), 0);
	points = points + sprintf(" %.8f %.8f %.8f\n", tr(1), tr(2), 0);
	points = points + sprintf(" %.8f %.8f %.8f\n", tl(1), tl(2), 0);

	points = sprintf("POINTS %d float\n", 4) + points;
	cells  = "";
	cells  = cells + "2 0 1\n";
	cells  = cells + "2 1 2\n";
	cells  = cells + "2 2 3\n";
	cells  = cells + "2 3 0\n";
	cells  = sprintf("CELLS %d %d\n",4,3*4) + cells;

	cells_type = "";
	cells_type = cells_type + '3\n';
	cells_type = cells_type + '3\n';
	cells_type = cells_type + '3\n';
	cells_type = cells_type + '3\n';
	cells_type = sprintf("CELL_TYPES %d \n", 4) + cells_type;
	fprintf(fout, header + points + cells + cells_type );
	fclose(fout);
end