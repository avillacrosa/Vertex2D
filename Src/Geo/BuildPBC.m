function Geo = BuildPBC(Geo, trueCells)
    newIdxs = zeros(0,2);
	nx = Geo.nx+3;
    ny = Geo.ny+3;
    % Apply PBC
    for ct = 1:length(trueCells)
	    c = trueCells(ct);
        
	    top   = Geo.Cells(c).Y(:,2) > +Geo.BoxL(2)/2;
        Geo.Cells(c).T(top,:) = Geo.Cells(c).T(top,:) - (nx-3);
        Geo.Cells(c).Y(top,2) = Geo.Cells(c).Y(top,2) - Geo.BoxL(2);
        Geo.Cells(c).YImage(top,2) = -1;
        if any(top)
            newIdxs(end+1,:)=[c, c - (nx-3)];
        end
    
        bot   = Geo.Cells(c).Y(:,2) < -Geo.BoxL(2)/2;
        Geo.Cells(c).T(bot,:) = Geo.Cells(c).T(bot,:) + (nx-3);
        Geo.Cells(c).Y(bot,2) = +1;
        if any(bot)
            newIdxs(end+1,:)=[c, c + (nx-3)];
        end
    
        right = Geo.Cells(c).Y(:,1) > +Geo.BoxL(1)/2;
        Geo.Cells(c).T(right,:) = Geo.Cells(c).T(right,:) - (nx-3)*ny;
        Geo.Cells(c).Y(right,1) = Geo.Cells(c).Y(right,1) - Geo.BoxL(1);
        Geo.Cells(c).YImage(right,1) = -1;
        if any(right)
            if any(top) || any(bot)
                newIdxs(end+1,:) = [c, newIdxs(end,2)-(nx-3)*ny];
            end
            newIdxs(end+1,:) = [c, c - (nx-3)*ny];
        end
    
        left  =  Geo.Cells(c).Y(:,1) < -Geo.BoxL(1)/2;
        Geo.Cells(c).T(left,:) = Geo.Cells(c).T(left,:) + (nx-3)*ny;
        Geo.Cells(c).Y(left,1) = Geo.Cells(c).Y(left,1) + Geo.BoxL(1);
        Geo.Cells(c).YImage(left,1) = +1;
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
	Geo.nCells = length(trueCells);
end
