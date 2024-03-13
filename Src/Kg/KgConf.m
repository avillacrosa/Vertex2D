function [g,K,EnergyF]=KgConf(Geo, Set)
	ge = zeros(Geo.numY+Geo.nCells,2);
    Ke = zeros((Geo.numY+Geo.nCells)*2);
    k  = 0.002;
    r0 = 4;
	for c = 1:Geo.nCells
        TIds = Geo.Cells(c).T;
        extI = sum(ismember(TIds, Geo.XgID),2) > 0;
        Ys   = Geo.Cells(c).Y(extI,:);
        YIds = Geo.Cells(c).globalIds(extI);
        %% TODO: brute forcing, vectorize...
        for yi = 1:length(YIds)
            r = vecnorm(Ys(yi,:));
            if r < r0
                continue
            end
            [f, Ki] = KgConf_e(Ys(yi,:), r0);
	        ge(YIds(yi),:) = 3*k*f;
            trueIds = [2*YIds(yi)-1,2*YIds(yi)];
            Ke(trueIds,trueIds) = 3*k*Ki;
        end
	end
	g = reshape(ge', (Geo.numY+Geo.nCells)*2, 1);
    K = Ke;
	EnergyF = 0;
end
