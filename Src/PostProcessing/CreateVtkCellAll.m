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

	nYTot = 0;
	for c = 1:Geo.nCells
		Ys = Geo.Cells(c).Y;
		X = Geo.Cells(c).X;
		nY = size(Ys,1);
		for yi = 1:nY
    		points = points + sprintf(" %.6f %.6f %.6f\n",...
		           				Ys(yi,1),Ys(yi,2), 0);
		end
		points = points + sprintf(" %.6f %.6f %.6f\n",...
				           		X(1), X(2), 0);

		for ci = 1:max((nY-1),0)
			cells    = cells + sprintf("3 %d %d %d\n",...
					        	ci-1+nYTot, ci+nYTot, nY+nYTot);
		end
		cells    = cells + sprintf("3 %d %d %d\n",...
							        	nY-1+nYTot, nYTot, nY+nYTot);

		nYTot = nYTot + nY + 1;
	end
	for numTries=1:nYTot-Geo.nCells
    	cells_type = cells_type + sprintf('%d\n',5);
	end
	points = sprintf("POINTS %d float\n", nYTot) + points;
	cells  = sprintf("CELLS %d %d\n",nYTot-Geo.nCells,4*(nYTot-Geo.nCells)) + cells;
	cells_type = sprintf("CELL_TYPES %d \n", nYTot-Geo.nCells) + cells_type;

	fprintf(fout, header + points + cells + cells_type);

	fclose(fout);
end