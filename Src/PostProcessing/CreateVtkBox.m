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
	tl = [+box/2,-box/2];
	points = sprintf(" %.8f %.8f %.8f\n", bl(1), bl(2), 0);
	points = sprintf("POINTS %d float\n", 4+1) + points;
	cells  = "1 1 2 3 4\n";
	cells  = sprintf("CELLS %d %d\n",1,5) + cells;
	cells_type = '8';
	cells_type = sprintf("CELL_TYPES %d \n", 8) + cells_type;
	fprintf(fout, header + points + cells + cells_type );
	fclose(fout);
end