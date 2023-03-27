function CreateVtkCell(Geo_0, Geo, Set, Step)
	%% ============================= INITIATE =============================
	str0=Set.OutputFolder;                          % First Name of the file 
	fileExtension='.vtk';                            % extension
	
	newSubFolder = fullfile(pwd, str0, 'Cells');
	if ~exist(newSubFolder, 'dir')
    	mkdir(newSubFolder);
	end
	for c = 1:Geo.nCells
		Ys = Geo.Cells(c).Y;
		X  = Geo.Cells(c).X;
		nY = size(Ys,1);
		nameout=fullfile(newSubFolder, ['Cell_', num2str(c, '%04d'), '_t', num2str(Step, '%04d'), fileExtension]);
		fout=fopen(nameout,'w');

		header = "# vtk DataFile Version 3.98\n";
		header = header + "Delaunay_vtk\n";
		header = header + "ASCII\n";
		header = header + "DATASET UNSTRUCTURED_GRID\n";

		points = ""; cells = ""; cells_type = ""; data = ""; data_id = "";
		for yi = 1:nY
    		points = points + sprintf(" %.8f %.8f %.8f\n",...
				           		Ys(yi,1),Ys(yi,2), 0);
		end
		points = points + sprintf(" %.8f %.8f %.8f\n", X(1),X(2),0);

		for ci = 1:max((nY-1),0)
			cells    = cells + sprintf("3 %d %d %d\n",...
					        	ci-1, ci, nY);
		end
		cells    = cells + sprintf("3 %d %d %d\n",...
							        	size(Ys,1)-1, 0, nY);

		for numTries=1:nY
        	cells_type = cells_type + sprintf('%d\n',5);
			dA = (Geo.Cells(c).Area-Geo_0.Cells(c).Area)/(Geo_0.Cells(c).Area);
%             dA = 0;
			data     = data + sprintf("%f \n", dA);
			data_id  = data_id + sprintf("%d \n", c);
		end

		points = sprintf("POINTS %d float\n", nY+1) + points;
		cells  = sprintf("CELLS %d %d\n",nY,4*nY) + cells;
		cells_type = sprintf("CELL_TYPES %d \n", nY) + cells_type;
		data = sprintf('SCALARS AreaChange float 1\nLOOKUP_TABLE default\n') + data;
		data_id = sprintf('CELL_DATA %d\n SCALARS Id float 1\nLOOKUP_TABLE default\n', nY) + data_id;
		fprintf(fout, header + points + cells + cells_type + data_id + data);
		fclose(fout);
	end
end