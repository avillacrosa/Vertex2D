function [Geo] = ApplyBC(t, Geo, Dofs, Set)
	if strcmpi(Set.BC, 'compress') && t > Set.BCStart && t < Set.BCStop
		prescgIds = (find(Dofs.Presc)+1)/2;
		fixIds = (find(Dofs.Fix)+1)/2;
		for c = 1:Geo.nCells
			Cell = Geo.Cells(c);
			hitsP = ismember(Cell.globalIds, prescgIds);
			hitsF = ismember(Cell.globalIds, fixIds);
			Geo.Cells(c).Y(hitsP,1) = Set.BCPrescribed + (t-Set.BCStart)*Set.BCdxdt;
			Geo.Cells(c).Y(hitsF,1) = Set.BCFix;
		end
	elseif strcmpi(Set.BC, 'periodic')
		for c = 1:Geo.nCells
			Cell = Geo.Cells(c);
			Ys = Cell.Y;
			% Add center of box here if necessary
			boxLim = Set.Box;
			outLeft  = find(Ys(:,1)<-boxLim);
			Geo.Cells(c).Y(outLeft) = Ys(outLeft) + boxLim;
			
			outRight = find(Ys(:,1)>boxLim);
			Geo.Cells(c).Y(outRight) = Ys(outRight) - boxLim;

			outBot   = find(Ys(:,2)<-boxLim);
			Geo.Cells(c).Y(outBot) = Ys(outBot) + boxLim;
			
			outTop   = find(Ys(:,2)>boxLim);
			Geo.Cells(c).Y(outTop) = Ys(outTop) - boxLim;
			% Switch statement here to find left right top bot
		end
	end
end