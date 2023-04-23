function GeoN = BuildPBC(Geo)
	XpID = false(Geo.nCells,1);
	XpID(1:(Geo.nx+1)) = true;
	% Also remove first column and row of real cells for PBC
	for ji = 1:(Geo.ny+1)
		idx = (ji-1)*(Geo.nx+1)+1;
		XpID(idx)=true;
	end
	trueCells = find(~XpID);
    nx = Geo.nx+3;
    ny = Geo.ny+3;
    trueCells = [13,14,18,19];
    trueCells = [15,16,17,21,22,23,27,28,29];
    newIdxs = zeros(0,2);
    % Apply PBC
    for ct = 1:length(trueCells)
	    c = trueCells(ct);
        
	    top   = Geo.Cells(c).Y(:,2) > +Geo.BoxL(2)/2;
        Geo.Cells(c).T(top,:) = Geo.Cells(c).T(top,:) - (nx-3);
        Geo.Cells(c).Y(top,2) = Geo.Cells(c).Y(top,2) - Geo.BoxL(2);
        if any(top)
            newIdxs(end+1,:)=[c, c - (nx-3)];
        end
    
        bot   = Geo.Cells(c).Y(:,2) < -Geo.BoxL(2)/2;
        Geo.Cells(c).T(bot,:) = Geo.Cells(c).T(bot,:) + (nx-3);
        Geo.Cells(c).Y(bot,2) = Geo.Cells(c).Y(bot,2) + Geo.BoxL(2);
        if any(bot)
            newIdxs(end+1,:)=[c, c + (nx-3)];
        end
    
        right = Geo.Cells(c).Y(:,1) > +Geo.BoxL(1)/2;
        Geo.Cells(c).T(right,:) = Geo.Cells(c).T(right,:) - (nx-3)*ny;
        Geo.Cells(c).Y(right,1) = Geo.Cells(c).Y(right,1) - Geo.BoxL(1);
        if any(right)
            if any(top) || any(bot)
                newIdxs(end+1,:) = [c, newIdxs(end,2)-(nx-3)*ny];
            end
            newIdxs(end+1,:) = [c, c - (nx-3)*ny];
        end
    
        left  =  Geo.Cells(c).Y(:,1) < -Geo.BoxL(1)/2;
        Geo.Cells(c).T(left,:) = Geo.Cells(c).T(left,:) + (nx-3)*ny;
        Geo.Cells(c).Y(left,1) = Geo.Cells(c).Y(left,1) + Geo.BoxL(1);
        if any(left)
            if ~isempty(newIdxs)
                newIdxs(end+1,:) = [c, newIdxs(2)-(nx-3)*ny];
            end
            newIdxs(end+1,:)=[c, c + (nx-3)*ny];
        end
    end
    % Update PBC tets
    for idx = 1:length(newIdxs)
        idxs = newIdxs(idx,:);
        newC = idxs(1);
        oldC = idxs(2);
        for ct = 1:length(trueCells)
    		c = trueCells(ct);
            Geo.Cells(c).T(Geo.Cells(c).T==oldC) = newC;
        end
    end
    % Do a final reorder 
    GeoN = Geo;
    for ct = 1:length(trueCells)
	    c = trueCells(ct);
        GeoN.Cells(ct) = Geo.Cells(c);
    end
    GeoN.Cells((length(trueCells)+1):length(Geo.Cells)) = [];
    GeoN.XgID  = [];
    GeoN.nCells = length(trueCells);
    for ct = 1:length(trueCells)
	    c = trueCells(ct);
        for ci = 1:GeoN.nCells
            GeoN.Cells(ci).T(GeoN.Cells(ci).T==c) = ct;
        end
    end
end
