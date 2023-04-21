function Geo = BuildPBC(Geo)
	XpID = false(Geo.nCells,1);
	XpID(1:(Geo.nx+1)) = true;

	% Also remove first column and row of real cells for PBC
	for ji = 1:(Geo.ny+1)
		idx = (ji-1)*(Geo.nx+1)+1;
		XpID(idx)=true;
	end
	trueCells = find(~XpID);
	trueCells = trueCells(end);

	for ct = 1:length(trueCells)
		c = trueCells(ct);

		top   = Geo.Cells(c).Y(:,2) > +Geo.BoxL(2)/2;
		if any(top)
			% Cp here is 4
			% THIS IS JUST BAD
% 			cp = c-(Geo.nx);

% 			cpTop = Geo.Cells(cp).Y(:,2) > -Geo.BoxL(2)/2;
			Geo.Cells(c).Y(top,2) = Geo.Cells(c).Y(top,2) - Geo.BoxL(2);
			%% Assume counter clockwise
			1
% 			Geo.Cells(c).T(top,:) = Geo.Cells(cp).T(cpTop,:);

% 			for cj = 1:Geo.nCells
% 				CellJ = Geo.Cells(cj);
% 				Geo.Cells(cj).T(CellJ.T==cp) = c;
% 			end
		end

		bot   = Geo.Cells(c).Y(:,2) < -Geo.BoxL(2)/2;
		if any(bot)
% 			cp = c+(Geo.nx);
% 			cpBot = Geo.Cells(cp).Y(:,2) < +Geo.BoxL(2)/2;
			Geo.Cells(c).Y(bot,2) = Geo.Cells(c).Y(bot,2) + Geo.BoxL(2);
% 			Geo.Cells(c).T(bot,:) = Geo.Cells(cp).T(cpBot,:);

% 			for cj = 1:Geo.nCells
% 				CellJ = Geo.Cells(cj);
% 				Geo.Cells(cj).T(CellJ.T==cp) = c;
% 			end
		end

		right = Geo.Cells(c).Y(:,1) > +Geo.BoxL(1)/2;
		if any(right)
% 			cp = c-Geo.nx*(Geo.ny+1);
% 			cpRight = Geo.Cells(cp).Y(:,1) > -Geo.BoxL(1)/2;
			Geo.Cells(c).Y(right,1) = Geo.Cells(c).Y(right,1) - Geo.BoxL(1);
% 			Geo.Cells(c).T(right,:) = Geo.Cells(cp).T(cpRight,:);

% 			for cj = 1:Geo.nCells
% 				CellJ = Geo.Cells(cj);
% 				Geo.Cells(cj).T(CellJ.T==cp) = c;
% 			end
		end

		
		left  = Geo.Cells(c).Y(:,1) < -Geo.BoxL(1)/2;
		if any(left)
% 			cp = c+Geo.nx*(Geo.ny+1);
% 			cpLeft = Geo.Cells(cp).Y(:,1) < +Geo.BoxL(1)/2;
			Geo.Cells(c).Y(left,1) = Geo.Cells(c).Y(left,1) + Geo.BoxL(1);
% 			Geo.Cells(c).T(left,:) = Geo.Cells(cp).T(cpLeft,:);

% 			for cj = 1:Geo.nCells
% 				CellJ = Geo.Cells(cj);
% 				Geo.Cells(cj).T(CellJ.T==cp) = c;
% 			end
		end
		1
% 		Geo.Cells(c).Y = Ys;
% 		Geo.Cells(c).T = Ts;
	end
	clc
	for ct = 1:length(trueCells)
		c = trueCells(ct)
		Geo.Cells(c).T
	end
end

		% Apply images & restore connectivity
% 		top   = Ys(:,2) > +Geo.BoxL(2)/2;
% 		YsIm(top,2) = -1;
% 		if any(top)
% 			cp = c-(Geo.nx);
% 			CellP = Geo.Cells(cp);
% 			inBoxP = CellP.Y(:,2)>-Geo.BoxL(2)/2;
% 			Ys(top,2) = CellP.Y(inBoxP,2);
% 			Geo.Cells(c).T(top,:) = CellP.T(inBoxP,:);
% 			for cjt = 1:length(trueCells)
% 				cj = trueCells(cjt);
% 				CellJ = Geo.Cells(cj);
% 				Geo.Cells(cj).T(CellJ.T==cp) = c;
% 			end
% 		end
% 
% 		bot   = Ys(:,2) < -Geo.BoxL(2)/2;
% 		YsIm(bot,2) = +1;
% 		if any(bot)
% 			cp = c+(Geo.nx);
% 			CellP = Geo.Cells(cp);
% 			inBoxP = CellP.Y(:,2)<+Geo.BoxL(2)/2;
% 			Ys(bot,2) = CellP.Y(inBoxP,2);
% 			Geo.Cells(c).T(bot,:) = CellP.T(inBoxP,:);
% 			for cjt = 1:length(trueCells)
% 				cj = trueCells(cjt);
% 				CellJ = Geo.Cells(cj);
% 				Geo.Cells(cj).T(CellJ.T==cp) = c;
% 			end
% 		end
% 
% 		right = Ys(:,1) > +Geo.BoxL(1)/2;
% 		YsIm(right,1) = -1;
% 		if any(right)
% 			cp = c-Geo.nx*(Geo.ny+1);
% 			CellP = Geo.Cells(cp);
% 			inBoxP = CellP.Y(:,1)>-Geo.BoxL(1)/2;
% 			Ys(right,1) = CellP.Y(inBoxP,1);
% 			Geo.Cells(c).T(right,:) = CellP.T(inBoxP,:);
% 			for cjt = 1:length(trueCells)
% 				cj = trueCells(cjt);
% 				CellJ = Geo.Cells(cj);
% 				Geo.Cells(cj).T(CellJ.T==cp) = c;
% 			end
% 		end
% 
% 		left  = Ys(:,1) < -Geo.BoxL(1)/2;
% 		YsIm(left,1) = +1;
% 		if any(left)
% 			cp = c+Geo.nx*(Geo.ny+1);
% 			CellP = Geo.Cells(cp);
% 			inBoxP = CellP.Y(:,1)<Geo.BoxL(1)/2;
% 			Ys(left,1) = CellP.Y(inBoxP,1);
% 			Geo.Cells(c).T(left,:) = CellP.T(inBoxP,:);
% 			for cjt = 1:length(trueCells)
% 				cj = trueCells(cjt);
% 				CellJ = Geo.Cells(cj);
% 				Geo.Cells(cj).T(CellJ.T==cp) = c;
% 			end
% 		end
% 		Geo.Cells(c).YImage = YsIm;
% 		Geo.Cells(c).Y = Ys;