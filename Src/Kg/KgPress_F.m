function [g,K,EnergyF]=KgPress_F(Geo, Set)
	ge = zeros(Geo.numY+Geo.nCells,2);
    f0      = 0.001*(1-exp(-Geo.t/10));
    Ke= zeros((Geo.numY+Geo.nCells)*2);
	for c = 1:Geo.nCells
        TIds = Geo.Cells(c).T;
        extI   = sum(ismember(TIds, Geo.XgID),2) > 0;
        Ys   = Geo.Cells(c).Y(extI,:);
        YIds = Geo.Cells(c).globalIds(extI);
	    ge(YIds,:) = Ys;
        trueIds = [2*YIds-1,2*YIds];
        Ke(trueIds,trueIds) = eye(size(Ke(trueIds,trueIds)));
        if any(extI)
		    Ys   = Geo.Cells(c).Y;
            YIds = Geo.Cells(c).globalIds;
		    ge(YIds,:) = Ys;
            trueIds = [2*YIds-1,2*YIds];
            Ke(trueIds,trueIds) = eye(size(Ke(trueIds,trueIds)));
        end
	end
	g = f0.*reshape(ge', (Geo.numY+Geo.nCells)*2, 1);
    K = f0.*Ke;
	EnergyF = 0;
end
