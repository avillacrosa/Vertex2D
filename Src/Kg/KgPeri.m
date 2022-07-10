function [g, K, E] = KgPeri(Geo_0, Geo, Set)
	[g, K]	= initializeKg(Geo, Set);
	E		= 0;
	for c = 1:Geo.nCells
		Cell = Geo.Cells(c);
        Cell_0 = Geo_0.Cells(c);
		Ys = Geo.Cells(c).Y;
		ge = zeros(size(g, 1), 1);
        Ke = zeros(size(g, 1));
        for yi = 1:size(Ys,1)
	        if yi+1 > size(Ys,1)
		        y1 = Ys(1,:);
		        y2 = Ys(size(Ys,1),:);
				% TODO FIXME THE BUG WAS HERE IN THE GLOBAL INDEXES,
				% FOCUS MAN!
		        nY = [Cell.globalIds(1), Cell.globalIds(size(Ys,1))];
	        else
		        y1 = Ys(yi,:);
		        y2 = Ys(yi+1,:);
		        nY = [Cell.globalIds(yi), Cell.globalIds(yi+1)];
	        end
	        [gl, Kl] = KgPeri_e(y1, y2);
%             Kl  = fact*Kl; % MULTIPLYING HERE IS THE SAME AS MULTIPLYING
%             OUTSIDE THE LENGHT LOOP
	        ge	= Assembleg(ge,gl,nY);
	        Ke	= AssembleK(Ke,Kl,nY);
        end
        % THINK IT'S PRETTY CLEAR NOW THERE IS SOMETHING WRONG INSIDE
        % KgPeri_e
		fact=Cell.Peri/Cell_0.Peri^2; % 1 at first iteration so it does not play a role
		g = g + fact*ge;
		K = fact*Ke + (ge)*(ge')/(Cell_0.Peri^2); 
	end
end