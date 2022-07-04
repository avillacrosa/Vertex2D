function CreateVtkCellAll(Geo, Set, Step)
	%% ============================= INITIATE =============================
	str0=Set.OutputFolder;                          % First Name of the file 
	fileExtension='.vtk';                            % extension
	
	newSubFolder = fullfile(pwd, str0, 'Cells');
	if ~exist(newSubFolder, 'dir')
    	mkdir(newSubFolder);
	end

	nameout=fullfile(newSubFolder, ['Cell_All_t', num2str(Step, '%04d'), fileExtension]);
	fout=fopen(nameout,'w');

	header = "# vtk DataFile Version 3.98\n";
	header = header + "Delaunay_vtk\n";
	header = header + "ASCII\n";
	header = header + "DATASET UNSTRUCTURED_GRID\n";
	points = ""; cells = ""; cells_type = "";

	totCells = 0; nverts = 0;

	for c = 1:Geo.nCells
		Ys = Geo.Cells(c).Y;
        for yi = 1:length(Ys)
	        points = points + sprintf(" %.8f %.8f 0\n",...
						           Ys(yi,1),Ys(yi,2));
        end
		nverts = nverts + length(Ys) - nTriFaces;
	end
	for numTries=1:totCells
    	cells_type = cells_type + sprintf('%d\n',5);
	end
	points = sprintf("POINTS %d float\n", nverts) + points;
	cells  = sprintf("CELLS %d %d\n",totCells,3*totCells) + cells;
	cells_type = sprintf("CELL_TYPES %d \n", totCells) + cells_type;

	fprintf(fout, header + points + cells + cells_type);

	fclose(fout);
end