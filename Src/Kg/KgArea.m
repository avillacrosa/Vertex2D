function [g, K, E] = KgArea(Geo_0, Geo, Set)
	[g, K]	= initializeKg(Geo, Set);
	E		= 0;
	for c = 1:Geo.nCells
% 		if Geo.Remodelling
% 			if ~ismember(c,Geo.AssembleNodes)
%         		continue
% 			end
% 		end
		Cell  = Geo.Cells(c);
		Cell0 = Geo_0.Cells(c);
		X  = Geo.Cells(c).X;
		Ys = Geo.Cells(c).Y;
		Ke = zeros(size(g, 1)); ge = zeros(size(g, 1), 1);
		% TODO FIXME LAMBDA STILL MISSING HERE
		factg = Set.lambdaA*(Cell.Area-Cell0.Area)/(Cell0.Area)^2;
		for t = 1:size(Ys,1)
			if t+1 > size(Ys,1)
				y1 = Ys(1,:);
				y2 = Ys(size(Ys,1),:);
				% THIS IS OK
				nY = [Cell.globalIds(1), Cell.globalIds(size(Ys,1)), Cell.cglobalIds];
			else
				y1 = Ys(t,:);
				y2 = Ys(t+1,:);
				% THIS IS OK
				nY = [Cell.globalIds(t), Cell.globalIds(t+1), Cell.cglobalIds];
			end
			if Geo.Remodelling
				if ~any(ismember(nY,Geo.AssemblegIds))
        		    continue
				end
			end
			y3 = X;
			[gs, Ks] = KgArea_e(y1, y2, y3);
			ge	= Assembleg(ge,gs,nY);
			Ke	= AssembleK(Ke,Ks,nY);
		end
		g   = g+factg*ge;
		K   = K+factg*Ke+((ge)*(ge'))/Cell0.Area^2*Set.lambdaA; % What is this?
	end
end